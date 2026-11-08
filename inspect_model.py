
import tensorflow as tf
import keras

model = keras.models.load_model(
    "AGROSCAN_ResNet50_best.keras",
    compile=False
)

print("\n========== DATA AUGMENTATION ==========")

augmentation = model.get_layer("data_augmentation")

print("Augmentation configuration:")
print(augmentation.get_config())

print("\nAugmentation layers:")
for layer in augmentation.layers:
    print("\nLayer:", layer.name)
    print("Type:", layer.__class__.__name__)
    print("Config:", layer.get_config())

print("\n========== RESNET50 INPUT ==========")

resnet = model.get_layer("resnet50")

print("ResNet input shape:", resnet.input_shape)

print("\nFirst ResNet layers:")
for layer in resnet.layers[:8]:
    print(layer.name, ":", layer.__class__.__name__)

print("\n========== FINAL OUTPUT ==========")
print("Output shape:", model.output_shape)
