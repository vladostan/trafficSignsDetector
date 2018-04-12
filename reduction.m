function bboxes_reduced = reduction(bboxes)

global lowerBound upperBound IoU

% Ban small regions
keep = banSmallPerimeters(bboxes);
bboxes_reduced = bboxes(keep,:);

% Ban overlapping regions
keep = banOverlapRegions(bboxes_reduced, lowerBound, upperBound, IoU);
bboxes_reduced = bboxes_reduced(keep,:);

end