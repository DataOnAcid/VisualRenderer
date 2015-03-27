#! /usr/bin/env python

from bokeh.plotting import *
import sys
import numpy
from scipy.interpolate import griddata

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

output_file("image.html", title="image.py example")

p = figure(title="Data on Acid",x_range=[0, 200], y_range=[0, 200])
p.image(image=[SurfaceMesh], x=[0], y=[0], dw=[200], dh=[200], palette="Spectral11")
show(p)
