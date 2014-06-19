Model Reconstruction from Images
===================
![Reconstruction](https://raw.githubusercontent.com/yazk/modelreconstruction/master/modelreconstruction/screenshots/cube_final.png)

_Senior Project - Spring 2010_
Language: MATLAB
An application that takes images and reconstructs a cloud of points in 3D using computer vision algorithms. The point cloud is then made into a 3D object which enables the user to place the object into their virtual environment. For the demonstration purposes, the 3D objects that my application produces were placed into Google Earth.

**Layout**
/input  - input images
/lib    - feature matching and camera calibration (extract to root). Default values have been computed and included for test images.
/misc   - additional MATLAB scripts, may be useful for debugging
/output - reconstructed 3D model (OBJ)