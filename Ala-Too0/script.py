import sys 
from numpy import *
from string import * 
from mayavi.mlab import *
from mayavi import *
from mayavi.modules.axes import Axes
from mayavi.api import Engine

fname_base="./2016-08-18-58091-on-sl032/electricX_2016-08-18-58091-on-sl03200000015.dat.electric"
t=1.500000e-02
Lx=1.142400e+00
Ly=5.000000e-01
nx=100
ny=40
name="beam electric"
shot_name="2016-08-18-58091-on-sl032"
units=    "non-dimensional (field)"

pic_mesh = zeros((nx,ny),dtype=float)
xpos     = zeros((nx,ny),dtype=float)
ypos     = zeros((nx,ny),dtype=float)


filehandle = open (fname_base, 'r')

for i in range(0,nx):
    for k in range(0,ny):
        string = filehandle.readline ()
#        print string
        lst = split(string,' ')
        n = 0
        s = len(lst)
        while n < s:
           if lst[n] == '' or lst[n] == '\n':
              del lst[n]
              s = len(lst)
           else:
              n = n+1
        
        if len(lst) >= 5:
           if i == 1 and k == 1:
              hx = float(lst[2])
              hy = float(lst[3])

           xpos[i,k]     = float(lst[2])
           ypos[i,k]     = float(lst[3])
           pic_mesh[i,k] = float(lst[4])


#print mesh

#filehandle.close ()

xmax = Lx
ymax = Ly
print hx,hy,xmax,ymax
#src = pipeline.scalar_field(pic_mesh)

#pipeline.iso_surface(src,extent=[0,xmax,0,0,0,0.0])

#pw = pipeline.image_plane_widget(src,
#                            plane_orientation='z_axes',
#                            slice_index=10
#                           ,extent=[0,xmax,0,ymax,0,0]
#                        )

imh = imshow(pic_mesh) #,extent=[0,xmax,0,ymax,0,0])

#ax = axes(imh)

#ax.axes.use_ranges = True
#ax.axes.ranges = array([  0.,   xmax,   0.,  ymax,   0.,   0.])


t_str= "%e" % t

title_str ="VARIANT: " + shot_name + "\n\n"+name + ', t = ' + t_str
title(title_str)

xlabel('X',object=imh)
scb = scalarbar(object=imh, title=units, nb_labels=8)

#engine = mayavi.engine

ax = engine.scenes[0].children[0].children[0].children[2]
# 1.  get AX object without ENGINE (find out through prints whose child it is)
# 2.  introduce norming and possibly smooth
# 3.  norm beam density in such a way that all the three component maps together will be 0
# 4.  increase title font
# 5.  enlarge picture
print ax   
#ax = scb.children[2]

ax.axes.use_ranges = True
ax.axes.ranges = array([  0.,   xmax,   0.,  ymax,   0.,   0.])


#engine = mayavi.engine
#sc = engine.scenes[0]
#sc.scene.z_plus_view()

view(0,0)

savefn = fname_base + '.png'

savefig(savefn) # size=[1480,1024])


sys.exit()