from __future__ import print_function
from keras.preprocessing.image import ImageDataGenerator, array_to_img, img_to_array, load_img
import os
import keras
from keras.datasets import mnist
from keras.models import Sequential
from keras.layers import Dense, Dropout, Flatten, LeakyReLU
from keras.layers import Conv2D, AveragePooling2D, MaxPooling2D, ZeroPadding2D
from keras.callbacks import ModelCheckpoint
import numpy



# class ImageRename():
#     def __init__(self, path):
#         self.categ = path
#         self.path = '/Users/pro/Desktop/data/' + path

#     def rename(self, j):
#         filelist = os.listdir(self.path)
#         total_num = len(filelist)

#         i = 0
#         for item in filelist:
#             src = os.path.join(os.path.abspath(self.path), item)
#             dst = os.path.join(os.path.abspath(
#                 self.path), self.categ + '_' + j + '_' + format(str(i + 1)) + '.jpg')
#             os.rename(src, dst)
#             print ('converting %s to %s ...' % (src, dst))
#             i = i + 1
#         print ('total %d to rename & converted %d jpgs' % (total_num, i))


# if __name__ == '__main__':
#     namelist = ['basketweave', 'camouflage', 'chinese-royal-texture', 'fleur-de-lis', 'gingham', 'ikat', 'pasiley', 'quatrefoil', 'scale']
#     for i in range(len(namelist)):
#         newname = ImageRename(namelist[i])
#         newname.rename(str(i))

# datagen = ImageDataGenerator(
#         rotation_range=90,
#         rescale=1. / 255,
#         #shuffle=True,
#         #width_shift_range=0.2,
#         #height_shift_range=0.2,
#         #shear_range=0.2,
#         #zoom_range=0.2,
#         horizontal_flip=True,)


# def load_img_folder(path):
#     filelist = os.listdir(path)
#     return filelist

# # 'basketweave', 'camouflage', 'chinese-royal-texture', 'fleur-de-lis', 'gingham', 'ikat', 'pasiley', 'quatrefoil'
# namelist = ['scale']
# num = 9
# for name in namelist:
#     img_folder = load_img_folder('/Users/pro/Desktop/data/' + name)
#     print(img_folder)
#     for img in img_folder:
#         img = load_img('/Users/pro/Desktop/data/' + name + '/' + img)
#         x = img_to_array(img)
#         x = x.reshape((1,) + x.shape)
#         i = 0
#         for batch in datagen.flow(x, batch_size=1,
#                                   save_to_dir='/Users/pro/Desktop/data/train/' + str(num) + '/', save_prefix=name, save_format='jpg'):
#             i += 1
#             if i > 19:
#                 break
#     num += 1
def create_model():
    model = Sequential()
    # model.add(ZeroPadding2D((1,1),input_shape=input_shape))
    model.add(Conv2D(16, kernel_size=(2, 2),
                     activation='relu', input_shape=input_shape))
    model.add(AveragePooling2D(pool_size=(2, 2)))

    model.add(Dropout(0.5))
    model.add(Conv2D(36, (2, 2), activation='relu'))
    model.add(AveragePooling2D(pool_size=(2, 2)))

    model.add(Dropout(0.5))
    model.add(Conv2D(64, (2, 2), activation='relu'))
    model.add(AveragePooling2D(pool_size=(2, 2)))
    #
    model.add(Dropout(0.5))
    model.add(Conv2D(100, (2, 2), activation='relu'))
    model.add(AveragePooling2D(pool_size=(2, 2)))

    # model.add(Dropout(0.5))
    # model.add(Conv2D(144, (2,2), activation='relu'))
    # model.add(AveragePooling2D(pool_size=(2, 2)))

    model.add(Flatten())  # 对数组进行降维，返回折叠后的一位数组
    model.add(Dense(864, activation='relu'))  # 一个全连接层（稠密层，dense layer）
    model.add(Dropout(0.2))  # dropout层是一个正则化矩阵，随机的设置输入值为零来避免过拟合
    model.add(Dense(288, activation='relu'))
    model.add(Dropout(0.2))
    model.add(Dense(num_classes, activation='softmax'))
    model.compile(loss=keras.losses.categorical_crossentropy, optimizer=keras.optimizers.Adam(),
                  metrics=['accuracy'])
    return model


def train_and_evaluate_model(model):
    filepath = "weights.best.hdf5"
    checkpoint = ModelCheckpoint(
        filepath, monitor='val_acc', verbose=1, save_best_only=True, mode=max)
    callbacks_list = [checkpoint]

#-------------------------------------------------
    train_datagen = ImageDataGenerator(
        # rotation_range=90,
        rescale=1. / 255,
        # shuffle=True,
        # width_shift_range=0.2,
        # height_shift_range=0.2,
        # shear_range=0.2,
        # zoom_range=0.2,
        # horizontal_flip=True,
    )

    test_datagen = ImageDataGenerator(rescale=1. / 255)

    train_generator = train_datagen.flow_from_directory(
        '/root/texture-cnn/train',
        color_mode="grayscale",
        target_size=(32, 32),
        batch_size=16,
        shuffle=True,
        class_mode='categorical')

    validation_generator = test_datagen.flow_from_directory(
        '/root/texture-cnn/test',
        color_mode="grayscale",
        target_size=(32, 32),
        batch_size=16,
        class_mode='categorical')

    model.fit_generator(
        train_generator,
        steps_per_epoch=12000,
        epochs=30,
        validation_data=validation_generator,
        validation_steps=2000, verbose=1, callbacks=callbacks_list)
    class_dictionary = validation_generator.class_indices

    # 保存整个模型
    model.save('model.hdf5')
    # 保存模型的权重
    model.save_weights('model_weights.h5')

    return model.model.history.history['val_acc']


def model_test():
    global batch_size
    batch_size = 16
    global num_classes
    num_classes = 16
    global epochs
    epochs = 10
    global img_rows, img_cols
    img_rows, img_cols = 32, 32

    n_folds = 1

    global input_shape
    input_shape = (img_rows, img_cols, 1)

    results = []

    model = create_model()

    results.append(train_and_evaluate_model(model))
    print (results)

    print(numpy.sum(results) / n_folds)


if __name__ == '__main__':
    print(model_test())
