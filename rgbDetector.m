function bboxes = rgbDetector(img, color, colorspace, thresholds, xtimesbigger, xtimeslonger)
    
    % RGB split
    r = img(:,:,1);
    g = img(:,:,2);
    b = img(:,:,3);

    % Color-based segmentation
    if colorspace == 'HSV'
        switch(color)
            case 'red'
                seg = redHSV(img);
            case 'blue'
                seg = blueHSV(img);
        end
    elseif colorspace == 'RGB'
        switch(color)
            case 'red'
                seg = r > thresholds(1) & ...
                r./(r+g+b) > thresholds(2) & ...
                g./(r+g+b) < thresholds(3) & ...
                b./(r+g+b) < thresholds(3);
            case 'blue'
                seg = b > thresholds(1) & ...
                b./(r+g+b) > thresholds(2) & ...
                g./(r+g+b) < thresholds(3) & ...
                r./(r+g+b) < thresholds(3);
        end
    end

    % Morphological erosion
    se = strel('square',3);
    morph = imclose(seg,se);

    % Boundary following
    B = bwboundaries(morph, 8, 'noholes'); % Extract boundaries of white blobs
    maximum = max(cellfun(@length,B)); % Find length of longest contour

    % Remove short contour objects
    removeThese = cellfun(@numel,B)/2 < maximum/xtimesbigger;

    % Compute surrounging bounding boxes
    CC = bwconncomp(morph);
    stats = regionprops(CC, 'BoundingBox');
    stats(removeThese) = [];

    bboxes = [];
    % Ignore bbox if one side is 'x' times longer than another
    for i = 1:length(stats)
        if stats(i).BoundingBox(3) < xtimeslonger*stats(i).BoundingBox(4) && ...
            stats(i).BoundingBox(4) < xtimeslonger*stats(i).BoundingBox(3)
            bboxes = [bboxes; stats(i).BoundingBox];
        end
    end
    
end