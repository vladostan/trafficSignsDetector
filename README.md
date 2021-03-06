# Two step framework for traffic signs detection
## Consists of:
1. Generation of region proposals
2. Classification

## Generation of region proposals
Color thresholding and morphological operations in different colorspaces to detect red and blue objects.

Color segmentation algorithms that I've used are described here:

1. Floros G., Kyritsis K., Potamianos G. Database and baseline system for detecting degraded traffic signs in urban environments //Visual Information Processing (EUVIP), 2014 5th European Workshop on. � IEEE, 2014. � �. 1-5.
2. Shopa P., Sumitha N., Patra P. S. K. Traffic sign detection and recognition using OpenCV //Information Communication and Embedded Systems (ICICES), 2014 International Conference on. � IEEE, 2014. � �. 1-6.

## Transfer Learning and Fine-Tuning of ResNet-101
Retrained ResNet-101 CNN to classify 7 classes (background, giveway, noentry, nostop, parking, pedestrian, stop)

![](https://github.com/vladostan/trafficSignsDetector/blob/master/imgs/results/Result%20(32).JPG?raw=true)

### Requirements
* Matlab2017b or later.
* [Download ResNet with my weights from Google Drive](https://drive.google.com/file/d/1M_s7DWkeaLg6vAhWepM7KCgDv9SKS9Pe/view?usp=sharing)

### Images used in the project
* [Traffic Sign Database](http://inf-server.inf.uth.gr/~gpotamianos/traffic_sign_database.html)
* [Traffic Sign Recognition](http://www.vision.ee.ethz.ch/~timofter/traffic_signs/)
* Manually collected from open source