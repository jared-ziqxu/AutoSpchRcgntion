from __future__ import print_function

from mpl_toolkits.mplot3d import axes3d
import matplotlib.pyplot as plt
import numpy as np
import time


def generateZ(X, Y):
    '''
    fill in the matrix of Z, by looking for exact (x, y)
    '''
    Z = np.zeros_like(X)

    #update Z matrix

    return Z



fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

#X should be leaf number list
leaf_lst = [500,600,700,800,900,1000,1100,1200,1300,1400,1500] # list require to be filled in
leaf_array = np.array(leaf_lst)
#Y should be gauss number
gauss_lst = [500, 750, 1000, 1250, 1500, 1750, 2000, 2250, 2500, 2750, 3000]# list require to be filled in
gauss_array = np.array(gauss_lst)

X, Y = np.meshgrid(leaf_array, gauss_array)


# Set the z axis limits so they aren't recalculated each frame.
ax.set_zlim(-1, 1)

# Begin plotting.
wframe = None
tstart = time.time()

if wframe:
    ax.collections.remove(wframe)

    # Plot the new wireframe and pause briefly before continuing.
Z = generateZ(X, Y)
wframe = ax.plot_wireframe(X, Y, Z, rstride=2, cstride=2)
plt.pause(100)
