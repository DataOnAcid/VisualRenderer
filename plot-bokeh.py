#! /usr/bin/env python

# from bokeh.plotting import *
import sys
import numpy
from scipy.interpolate import griddata
import matplotlib
#matplotlib.use('Agg')
import matplotlib.pyplot as plt

file = sys.argv[1]
INPUT = open(file,"r")

x = []
y = []
r = []
Coordinates = []

while True:

    line = INPUT.readline()

    if not line:
        break

    cols = line.split()
    if cols[0] != "\"series\"":

        x.append(float(cols[1])+100)
        y.append(float(cols[2])+100)
        r.append(float(cols[3]))

P,Q = numpy.mgrid[0:200, 0:200]

SurfaceMesh = griddata((x,y), r, (P, Q), method='cubic')

def render_image(image,filename):

    plt.figure()
    a=plt.imshow(image.transpose(), cmap='Spectral',origin='lower',extent=[0,200,0,200])
    plt.axis('off')
    plt.savefig(filename,dpi=150,transparent=True,bbox_inches='tight')
    plt.clf()

render_image(SurfaceMesh,"image.png")

# output_file("baa.html", title="may even work")
#
# img = numpy.empty((200,200), dtype=numpy.uint32)
# view = img.view(dtype=numpy.uint8).reshape((200, 200, 4))
# for i in range(200):
#     for j in range(200):
#         view[i, j, 0] = int(x/200*255)
#         view[i, j, 1] = 158
#         view[i, j, 2] = int(y/200*255)
#         view[i, j, 3] = 255
#
#
# output_file("image_rgba.html", title="image_rgba.py example")
#
# p = figure(x_range=[0,200], y_range=[0,200])
# p.image_rgba(image=[img], x=[0], y=[0], dw=[10], dh=[10])
#
# show(p)
