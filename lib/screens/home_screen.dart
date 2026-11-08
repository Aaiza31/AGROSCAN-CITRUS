import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../localization/app_strings.dart';
import '../models/disease_info.dart';
import '../services/disease_detector.dart';
import '../services/language_controller.dart';
import 'disease_detail_screen.dart';
import 'language_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Image picker
  final ImagePicker _picker = ImagePicker();

  // TensorFlow Lite detector
  final DiseaseDetector _detector = DiseaseDetector();

  // Selected image
  File? _selectedImage;

  // Track which source was used (camera or gallery)
  ImageSource? _imageSource;

  // Loading states
  bool _isPickingImage = false;
  bool _isScanning = false;

  // Prediction result
  DiseasePrediction? _prediction;

  String get _currentLang => LanguageController.instance.languageCode;

  // ==========================================================
  // CAMERA AND GALLERY
  // ==========================================================

  Future<void> _pickImage(ImageSource source) async {
    if (_isPickingImage || _isScanning) return;

    setState(() {
      _isPickingImage = true;
      _prediction = null;
    });

    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 85,
      );

      if (image != null && mounted) {
        setState(() {
          _selectedImage = File(image.path);
          _imageSource = source;
        });
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.imageSelectionFailed(_currentLang, e)),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isPickingImage = false;
        });
      }
    }
  }

  // ==========================================================
  // REMOVE IMAGE
  // ==========================================================

  void _removeImage() {
    if (_isScanning) return;

    setState(() {
      _selectedImage = null;
      _imageSource = null;
      _prediction = null;
    });
  }

  // ==========================================================
  // AI DISEASE DETECTION
  // ==========================================================

  Future<void> _scanDisease() async {
    if (_selectedImage == null || _isScanning) return;

    setState(() {
      _isScanning = true;
      _prediction = null;
    });

    try {
      final result = await _detector.predict(_selectedImage!);

      if (!mounted) return;

      setState(() {
        _prediction = result;
      });

      await showDialog(
        context: context,
        builder: (dialogContext) {
          final lang = _currentLang;
          final localizedName =
              AppStrings.localizedDiseaseName(result.diseaseName, lang);

          return AlertDialog(
            backgroundColor: const Color(0xFFFFF2DB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              AppStrings.diseaseDetectionResult(lang),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF185C37),
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.eco,
                  color: Color(0xFF2E7D32),
                  size: 55,
                ),
                const SizedBox(height: 15),
                Text(
                  localizedName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF185C37),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  AppStrings.predictionConfidence(lang),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${result.confidence.toStringAsFixed(2)}%',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  AppStrings.aiDisclaimer(lang),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: Text(
                  AppStrings.close(lang),
                  style: const TextStyle(color: Colors.black54),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  final info = DiseaseDatabase.getInfo(
                    result.diseaseName,
                    lang: lang,
                  );
                  if (info != null && context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DiseaseDetailScreen(info: info),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.info_outline, size: 16),
                label: Text(
                  AppStrings.viewDetails(lang),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.detectionFailed(_currentLang, e)),
          duration: const Duration(seconds: 5),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isScanning = false;
        });
      }
    }
  }

  // ==========================================================
  // CLOSE MODEL
  // ==========================================================

  @override
  void dispose() {
    _detector.close();
    super.dispose();
  }

  // ==========================================================
  // HOME SCREEN UI
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final lang = _currentLang;
    final isUrdu = LanguageController.instance.isUrdu;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF2DB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF2DB),
        elevation: 0,
        title: Text(
          AppStrings.appTitle(lang),
          style: const TextStyle(
            color: Color(0xFF185C37),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LanguageSelectionScreen(
                      isFromSettings: true,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.translate, size: 18),
              label: Text(
                isUrdu ? 'اردو | EN' : 'EN | اردو',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF185C37),
                side: const BorderSide(color: Color(0xFF185C37), width: 1.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // TITLE
              Text(
                AppStrings.homeTitle(lang),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF185C37),
                ),
              ),

              const SizedBox(height: 10),

              Text(
                AppStrings.homeSubtitle(lang),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF555555),
                ),
              ),

              const SizedBox(height: 25),

              // IMAGE PREVIEW
              Container(
                width: double.infinity,
                height: 260,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFB7D5B7),
                    width: 1.5,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: _isPickingImage
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF2E7D32),
                          ),
                        )
                      : _selectedImage != null
                          ? Image.file(
                              _selectedImage!,
                              fit: BoxFit.contain,
                              width: double.infinity,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.eco,
                                  size: 80,
                                  color: Color(0xFF81C784),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  AppStrings.plantPlaceholder(lang),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                ),
              ),

              const SizedBox(height: 15),

              // REMOVE IMAGE BUTTON
              if (_selectedImage != null)
                TextButton.icon(
                  onPressed: _isScanning ? null : _removeImage,
                  icon: const Icon(Icons.delete_outline),
                  label: Text(AppStrings.removeImage(lang)),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                ),

              const SizedBox(height: 10),

              // CAMERA BUTTON - hide when gallery image is selected
              if (_imageSource != ImageSource.gallery)
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: _isPickingImage || _isScanning
                        ? null
                        : () => _pickImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: Text(
                      AppStrings.scanPlant(lang),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 15),

              // GALLERY BUTTON - hide when camera image is selected
              if (_imageSource != ImageSource.camera)
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton.icon(
                    onPressed: _isPickingImage || _isScanning
                        ? null
                        : () => _pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library),
                    label: Text(
                      AppStrings.uploadFromGallery(lang),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF2E7D32),
                      side: const BorderSide(
                        color: Color(0xFF2E7D32),
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 25),

              // SCAN DISEASE BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _selectedImage == null ||
                          _isPickingImage ||
                          _isScanning
                      ? null
                      : _scanDisease,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF185C37),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    disabledForegroundColor: Colors.grey.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: _isScanning
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              AppStrings.analyzing(lang),
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          AppStrings.scanDisease(lang),
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

              // ==================================================
              // PREDICTION RESULT CARD
              // ==================================================

              if (_prediction != null) ...[
                const SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0xFF2E7D32),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Color(0xFF2E7D32),
                        size: 40,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        AppStrings.detectionResultCardTitle(lang),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF185C37),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        AppStrings.localizedDiseaseName(
                          _prediction!.diseaseName,
                          lang,
                        ),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF185C37),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${AppStrings.confidenceLabel(lang)}'
                        '${_prediction!.confidence.toStringAsFixed(2)}%',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            final info = DiseaseDatabase.getInfo(
                              _prediction!.diseaseName,
                              lang: lang,
                            );
                            if (info != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      DiseaseDetailScreen(info: info),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.info_outline, size: 18),
                          label: Text(
                            AppStrings.viewDetails(lang),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF185C37),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 20),

              Text(
                AppStrings.footerText(lang),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF185C37),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
