
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class DiseasePrediction {
  final String diseaseName;
  final double confidence;
  final List<double> scores;

  DiseasePrediction({
    required this.diseaseName,
    required this.confidence,
    required this.scores,
  });
}

class DiseaseDetector {
  Interpreter? _interpreter;

  // Initial class mapping from the project dataset workbook.
  static const List<String> classNames = [
    'Black Spot',
    'Canker',
    'Greening / HLB',
    'Healthy',
  ];

  // Load TensorFlow Lite model.
  Future<void> loadModel() async {
    if (_interpreter != null) return;

    _interpreter = await Interpreter.fromAsset(
      'assets/models/citrus_model.tflite',
    );
  }

  // Predict disease from selected image.
  Future<DiseasePrediction> predict(File imageFile) async {
    await loadModel();

    final Uint8List imageBytes = await imageFile.readAsBytes();

    img.Image? decodedImage = img.decodeImage(imageBytes);

    if (decodedImage == null) {
      throw Exception('Unable to read the selected image.');
    }

    // Correct image orientation.
    decodedImage = img.bakeOrientation(decodedImage);

    // Resize image to model input size.
    final img.Image resizedImage = img.copyResize(
      decodedImage,
      width: 224,
      height: 224,
      interpolation: img.Interpolation.linear,
    );

    // Model input: [1, 224, 224, 3].
    // Send RGB values from 0 to 255.
    // BGR conversion and mean subtraction are already
    // embedded inside the trained model.
    final input = List.generate(
      1,
      (_) => List.generate(
        224,
        (y) => List.generate(
          224,
          (x) {
            final pixel = resizedImage.getPixel(x, y);

            return [
              pixel.r.toDouble(),
              pixel.g.toDouble(),
              pixel.b.toDouble(),
            ];
          },
        ),
      ),
    );

    // Model output: [1, 4].
    final output = List.generate(
      1,
      (_) => List<double>.filled(4, 0.0),
    );

    _interpreter!.run(input, output);

    final List<double> scores = output[0];

    if (scores.length != classNames.length) {
      throw Exception('Model output does not match four classes.');
    }

    // Find class with highest score.
    int bestIndex = 0;

    for (int i = 1; i < scores.length; i++) {
      if (scores[i] > scores[bestIndex]) {
        bestIndex = i;
      }
    }

    return DiseasePrediction(
      diseaseName: classNames[bestIndex],
      confidence: scores[bestIndex] * 100,
      scores: scores,
    );
  }

  // Release model resources.
  void close() {
    _interpreter?.close();
    _interpreter = null;
  }
}
