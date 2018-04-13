%% Two step framework for traffic signs detection
clc; close all; clear;

%% Global variables (hyperparameters)
global xtimesbigger xtimeslonger red_thresholds blue_thresholds lowerBound upperBound IoU

xtimesbigger = 10; % Threshold for small contours removal
xtimeslonger = 2; % Threshold for aspect ratio of bounding box
red_thresholds = [90 0.50 0.25]; % Thresholds to isolate red color objects
blue_thresholds = [150 0.50 0.25]; % Thresholds to isolate blue color objects

% bbox simplification thresholds:
lowerBound = 0.75;  
IoU = 0.5;

% Load retrained CNN 
% Retrained ResNet-101
% See trainCNN for details
if ~exist('net', 'var')
    load('trafficSignDetector');
end

%% Read and process image (100 Scenes available)
img = imread('imgs/detection/Scene (1).jpg');
% img = imread('imgs/detection/Scene (2).jpg');
% img = imread('imgs/detection/Scene (3).jpg');
% img = imread('imgs/detection/Scene (4).jpg');
% img = imread('imgs/detection/Scene (5).jpg');

% Detection
tic
bboxes = rpn(img);
upperBound = 0.99;
bboxes_reduced = reduction(bboxes);
upperBound = 1;
[bboxes_signs, labels_signs] = classification(img, net, bboxes_reduced);
toc

% Visualisation
img = insertObjectAnnotation(img, 'rectangle', bboxes_signs, cellstr(labels_signs), 'LineWidth', 3, 'FontSize', 18);
imshow(img);

