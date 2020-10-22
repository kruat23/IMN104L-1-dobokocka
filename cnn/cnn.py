import numpy as np
import tensorflow as tf
from tensorflow.keras import models
from tensorflow.keras import layers
from tensorflow.keras import preprocessing
import pathlib

def preprocess():
    data_dir = pathlib.Path("images")

    batch_size = 32
    img_height = 130
    img_width = 130

    train_ds = preprocessing.image_dataset_from_directory(
        data_dir,
        label_mode='categorical',
        color_mode='grayscale',
        validation_split=0.2,
        subset="training",
        seed=123,
        image_size=(img_height, img_width),
        batch_size=batch_size)


    return train_ds

def train_cnn():
    train_ds = preprocess()
    class_names = train_ds.class_names
    print(class_names)