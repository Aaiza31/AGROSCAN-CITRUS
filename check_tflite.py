
import tensorflow as tf

interpreter = tf.lite.Interpreter(
    model_path="assets/models/citrus_model.tflite"
)

interpreter.allocate_tensors()

print("\n========== INPUT DETAILS ==========")

for item in interpreter.get_input_details():
    print(item)

print("\n========== OUTPUT DETAILS ==========")

for item in interpreter.get_output_details():
    print(item)
