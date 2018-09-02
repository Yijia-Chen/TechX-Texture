import cv2
import matplotlib.image as mpimg
from matplotlib.pylab import cm
import numpy as np
import os


def ColorMap(image, image_name):
    """Map the target image to a random color map to generate it
       in a different style
    """
    image_gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)  # Change the RGB image into Grayscale

    color_maps = ['viridis', 'plasma', 'inferno', 'magma',
                  'Greys', 'Purples', 'Blues', 'Greens', 'Oranges', 'Reds',
                  'YlOrBr', 'YlOrRd', 'OrRd', 'PuRd', 'RdPu', 'BuPu',
                  'GnBu', 'PuBu', 'YlGnBu', 'PuBuGn', 'BuGn', 'YlGn', 'binary',
                  'gist_yarg', 'gist_gray', 'gray', 'bone', 'pink',
                  'spring', 'summer', 'autumn', 'winter', 'cool', 'Wistia',
                  'hot', 'afmhot', 'gist_heat', 'copper', 'PiYG',
                  'PRGn', 'BrBG', 'PuOr', 'RdGy', 'RdBu', 'RdYlBu', 'RdYlGn',
                  'Spectral', 'coolwarm', 'bwr', 'seismic', 'flag', 'prism',
                  'ocean', 'gist_earth', 'terrain', 'gist_stern', 'gnuplot',
                  'gnuplot2', 'CMRmap', 'cubehelix', 'brg', 'gist_rainbow',
                  'rainbow', 'jet', 'nipy_spectral', 'gist_ncar', 'hsv']

    index = np.random.randint(len(color_maps))  # Randomly choose one style in colormap
    color = color_maps[index]
    im_color = getattr(cm, color)(image_gray)  # Apply the colormap style
    cv2.imwrite(image_name + '_converted' + '.jpg', im_color * 255)  # Save the converted RGB image


if __name__ == '__main__':
    path = input()
    img = mpimg.imread(path)
    img_name = (path.split('/')[-1]).split('.')[0]
    ColorMap(img, img_name)
    # im_color = Image.open('im_color.jpg')
    # im_color.show()
