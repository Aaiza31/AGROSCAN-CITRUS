
import tensorflow as tf
import keras
import numpy as np

MODEL_PATH = "AGROSCAN_ResNet50_best.keras"
OUTPUT_PATH = "citrus_model.tflite"

print("TensorFlow:", tf.__version__)
print("Keras:", keras.__version__)

# Load the complete trained model
model = keras.models.load_model(
    MODEL_PATH,
    compile=False
)

print("\nModel loaded successfully!")
print("Input shape:", model.input_shape)
print("Output shape:", model.output_shape)
print("Parameters:", model.count_params())

# Test the model with a sample RGB image tensor
sample = np.zeros((1, 224, 224, 3), dtype=np.float32)
prediction = model.predict(sample, verbose=0)

print("Prediction output:", prediction.shape)

# Convert to TensorFlow Lite
converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()

# Save the converted model
with open(OUTPUT_PATH, "wb") as f:
    f.write(tflite_model)

print("\nTFLite conversion successful!")
print("Saved:", OUTPUT_PATH)
print("File size:", round(len(tflite_model) / (1024 * 1024), 2), "MB")
