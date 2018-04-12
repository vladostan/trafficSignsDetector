function [bboxes_signs, labels_signs] = classification(img, net, bboxes_reduced)

global lowerBound upperBound IoU

classes = net.Layers(end).ClassNames;
labels = zeros(length(classes), 1);

for i = 1:size(bboxes_reduced,1)
    labels(i) = classify(net, imresize(imcrop(img, bboxes_reduced(i,:)), net.Layers(1).InputSize(1:2)));
end

background_index = find(strcmp(classes, 'background'));
bboxes_reduced = bboxes_reduced(labels ~= background_index,:);
labels(labels == background_index) = [];

keep = banOverlapRegions(bboxes_reduced, lowerBound, upperBound, IoU);
bboxes_signs = bboxes_reduced(keep,:);
labels_signs = labels(keep);
labels_signs = classes(labels_signs);

end