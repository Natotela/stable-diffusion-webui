import imageio.v2
import os
import sys


n = len(sys.argv)
img_name = 'input.png'
dimY = 2
dimX = 2
fps = dimY*dimX

if n >= 3:
    dimY = int(sys.argv[1])
    dimX = int(sys.argv[2])
    if n >= 4:
        img_name = str(sys.argv[3])
        if n >= 4:
            fps = int(sys.argv[4])
    

img = imageio.v2.imread(os.path.join('./', img_name))
h, w = img.shape[:2]
spacY = h / dimY
spacX = w / dimX
imagesNames = []

#forward move
for j in range(dimY):
    for i in range(dimX):
        curImageName = str(j) + 'x' + str(i) + '.png'
        imagesNames.append(curImageName)
        crop_img = img[int(j*spacY):int((j+1)*(spacY)), int(i*spacX):int((i+1)*(spacX+1))]
        imageio.v2.imwrite("cropped/" + str(curImageName), crop_img)
        
#backwards move
for j in reversed(range(dimY)):
    for i in reversed(range(dimX)):
        if ((i == dimY-1 and j == dimX-1) or (i == 0 and j == 0)):
            continue
        curImageName = str(j) + 'x' + str(i) + '.png'
        imagesNames.append(curImageName)
        crop_img = img[int(j*spacY):int((j+1)*(spacY)), int(i*spacX):int((i+1)*(spacX+1))]
        imageio.v2.imwrite("cropped/" + str(curImageName), crop_img)

images = list()
for filename in imagesNames:
    images.append(imageio.v2.imread('./cropped/' + filename))
imageio.mimsave('./output.gif', images, format='GIF', fps=fps) 
    

    