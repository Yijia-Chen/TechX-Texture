""" Pretty & simple image classifier app template. Deploy your own trained model or pre-trained model (VGG, ResNet, Densenet) to a web app using Flask
    
    'model_predit' function had been modified to fit our own model. A bonus prediction was also added in result part. Some decoding methods for ImageNet models was commented.

    Copyright (C) 2018  mtobeiyf

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
"""
from __future__ import division, print_function
# coding=utf-8
import sys
import os
import glob
import re
import numpy as np
import json

# Keras
from keras.applications.inception_v3 import preprocess_input
# from keras.applications.imagenet_utils import preprocess_input, decode_predictions
from keras.models import load_model
from keras.preprocessing import image

from gevent.pywsgi import WSGIServer

# Flask utils
from flask import Flask, redirect, url_for, request, render_template
from werkzeug.utils import secure_filename

target_size = (229, 229)

# Define a flask app
app = Flask(__name__)

# Model saved with Keras model.save()
MODEL_PATH = 'models/5-classes.model'

# Load your trained model
model = load_model(MODEL_PATH)
model._make_predict_function()          # Necessary
# print('Model loaded. Start serving...')

# You can also use pretrained model from Keras
# Check https://keras.io/applications/
# from keras.applications.resnet50 import ResNet50
# model = ResNet50(weights='imagenet')
print('Model loaded. Please check.')


def model_predict(img_path, model):
    img = image.load_img(img_path)
    if img.size != target_size:
        img = img.resize(target_size)

    if img.mode != 'RGB':
        img = img.convert('RGB')

    # Preprocessing the image
    x = image.img_to_array(img)
    # x = np.true_divide(x, 255)
    x = np.expand_dims(x, axis=0)

    # Be careful how your trained model deals with the input
    # otherwise, it won't make correct prediction!
    x = preprocess_input(x)

    preds = model.predict(x)
    tags = {0: 'Meander/Greek Key', 1: 'Polka Dot',
            2: 'Scale Pattern', 3: 'Tartan', 4: 'Yagasuri'}
    if np.max(preds[0]) < 0.7:
        return ("The photo does not match any pattern in our database.")
    else:
        preds = tags[np.argmax(preds[0])]
        return preds


@app.route('/', methods=['GET'])
def index():
    # Main page
    return render_template('index.html')


@app.route('/predict', methods=['GET', 'POST'])
def upload():
    if request.method == 'POST':
        # Get the file from post request
        f = request.files['file']

        # Save the file to ./uploads
        basepath = os.path.dirname(__file__)
        file_path = os.path.join(
            basepath, 'uploads', secure_filename(f.filename))
        f.save(file_path)

        # Make prediction
        if f.filename == 'hd.jpg':
            return json.dumps({'result': '何大'})
        else:
            preds = model_predict(file_path, model)
            result = preds

        # # Process your result for human
        # # pred_class = preds.argmax(axis=-1)            # Simple argmax
        # pred_class = decode_predictions(preds, top=1)   # ImageNet Decode
        # result = str(pred_class[0][0][1])               # Convert to string
        return json.dumps({'result': result})
    return None


if __name__ == '__main__':
    #app.run(port=28179, debug=True)

    http_server = WSGIServer(('', 28179), app)
    http_server.serve_forever()
