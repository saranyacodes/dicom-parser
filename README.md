# dicom-parser
Pre-process dicom files before opening them!

DICOM files are images saved in a Digital Imaging and Communications in Medicine format, and these can store information from medical scans such as MRI scans or CT scans. Over the term of Summer 2019, I collaborated with the Computer Graphics department and surgeons from the Hospital of the University of Pennsylvania to 3D visualize specific internal organs based off of CT scans. 

The parser is able to read in DICOM files that can be viewed with any DICOM viewer software such as OsiriX or ITK-Snap, and it can edit Hounsfield values and write to new DICOM files. Hounsfield values affect how each pixel of the CT scan is visualized on DICOM viewer software, and editing these values can allow for easier segmentation of organs if certain values are isolated. 

The following parser is written in Matlab code and can be run. Under the comment “do some operation to the new_pixelarray”, one can edit the following line to perform whatever operation to the Hounsfield pixel array to get the desired result. In the example code, the values are simply inverted.
