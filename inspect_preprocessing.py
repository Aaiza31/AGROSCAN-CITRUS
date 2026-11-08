
import keras
import json

model = keras.models.load_model(
    "AGROSCAN_ResNet50_best.keras",
    compile=False
)

config = model.get_config()

print("\n========== PREPROCESSING LAYERS ==========")

target_layers = [
    "data_augmentation",
    "get_item",
    "get_item_1",
    "get_item_2",
    "stack",
    "add"
]

for layer in config["layers"]:
    if layer["name"] in target_layers:
        print("\nLAYER:", layer["name"])
        print(json.dumps(layer, indent=2, default=str))

print("\n========== RESNET50 CONFIG ==========")

resnet = model.get_layer("resnet50")

print("Input:", resnet.input_shape)
print("First layer:", resnet.layers[1].name)
print("Last layer:", resnet.layers[-1].name)
