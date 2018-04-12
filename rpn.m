function bboxes = rpn(img)

% Generate Region Proposals

global xtimesbigger xtimeslonger red_thresholds blue_thresholds

% Generate bounding boxes
bboxes = [rgbDetector(img, 'red', 'RGB', red_thresholds, xtimesbigger, xtimeslonger);
    rgbDetector(img, 'blue', 'RGB', blue_thresholds, xtimesbigger, xtimeslonger);
    rgbDetector(img, 'red', 'HSV', [], xtimesbigger, xtimeslonger);
    rgbDetector(img, 'blue', 'HSV', [], xtimesbigger, xtimeslonger)]; 

end