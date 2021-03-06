from flask import Flask, request
from flask_cors import CORS, cross_origin
import json
import sys
import torch
import base64
import numpy as np
from PIL import Image
from io import BytesIO
from torchvision import transforms
from unet_model import Unet

app = Flask(__name__)
cors = CORS(app)


MODEL_PATH = '260_epoch_201_images.pth' # path to the saved best Unet model with its weights
WIDTH, HEIGHT = 512, 512  # input size (in pixels) to the Unet model
NN_INPUT_IMAGE_SIZE = (WIDTH, HEIGHT)
DEVICE = torch.device("cuda") if torch.cuda.is_available() else torch.device("cpu")

def image_preprocessing(image):
    global NN_INPUT_IMAGE_SIZE
    image = image.resize(NN_INPUT_IMAGE_SIZE, Image.Resampling.NEAREST)
    convert_tensor = transforms.ToTensor()
    return convert_tensor(image)

def image_postprocessing(output_mask, width, height):
    convert_pil_image = transforms.ToPILImage()
    output_mask = convert_pil_image(output_mask)
    output_mask = output_mask.resize((width, height), Image.Resampling.NEAREST)

    buffered = BytesIO()
    output_mask.save(buffered, format="JPEG")
    converted_output_mask = base64.b64encode(buffered.getvalue())

    return converted_output_mask

def converting_to_rgb_layers(x):
    switcher = {
        0: [255, 0, 0],  # granulation tissue
        1: [0, 255, 0],  # slough tissue
        2: [0, 0, 255],  # necrotic tissue
        3: [0, 0, 0]     # background
    }
    return switcher.get(int(x[0]), "error")

def image_decoding(model_output):
    zero_tensor = torch.zeros(model_output.shape[1], model_output.shape[2], 1)
    dominant_layers = torch.argmax(torch.tensor(model_output), dim=0).unsqueeze(2)
    three_dim_tensor = torch.cat((dominant_layers, zero_tensor, zero_tensor), dim=2)
    numpy_array = three_dim_tensor.detach().numpy()
    numpy_array = np.apply_along_axis(converting_to_rgb_layers, -1, numpy_array)
    return torch.from_numpy(np.transpose(numpy_array.astype('uint8'), (2, 0, 1)))

def count_color_ratio(output):
    binary_classes = torch.where(output > 0, 1, 0)
    r_total, g_total, b_total = map(int, (torch.sum(binary_classes[i]) for i in range(3)))
    return r_total, g_total, b_total

def load_unet_model():
    global MODEL_PATH, DEVICE
    model = Unet()
    model.load_state_dict(torch.load(MODEL_PATH, map_location=DEVICE))
    return model.to(DEVICE)

def run(image64):
    # loading the image
    try:
        raw_img = base64.b64decode(image64)
        #raw_img = Image.open(sys.argv[1])
        original_width, original_height = raw_img.size
    except:
        sys.exit("ERROR during reading the picture")

    # resizing image to the necessary size and converting it to the tensor
    img = image_preprocessing(raw_img).to(DEVICE)
    # loading NN model
    model = load_unet_model()
    # making predictions about the output mask
    output_mask = model(img.unsqueeze(0)).squeeze(0).cpu()
    output = image_decoding(output_mask)
    # counting the ratio of each class on the output mask
    red_ratio, green_ratio, blue_ratio = count_color_ratio(output)
    # converting the output to the original size and decoding in base64
    output = image_postprocessing(output, original_width, original_height)
    
    return output
    ####################################################################################################################
    #        red_ratio, green_ratio, blue_ratio - ?????????????????? ???????????????? ?????????????????????? ???????????????? (?????? pie chart)              #
    #                              output - ?????????????? ???????????????? (?????????????????? ?? base64)                                      #
    ####################################################################################################################



@app.route('/analyze', methods = ['POST'])
@cross_origin(origin='localhost',headers=['Content- Type','Authorization'])
def analyze():
    data = request.get_json()
    stauts = test()
    return json.dumps({"status":data})

@app.route('/test', methods = ['GET'])
def test():
    return json.dumps({"result":"success"})

def test():
    return "love"

if __name__== "__main__":
    app.run(port=2200,debug=True)





