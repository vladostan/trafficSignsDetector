function keep = banOverlapRegions(bboxes, lowerBound, upperBound, IoU)

% Overlapping regions simplification algorithm

ban = [];

num = size(bboxes,1);

for i = 1:num
    area_i = bboxes(i,3)*bboxes(i,4);
    for j = i+1:num
        
        area_j = bboxes(j,3)*bboxes(j,4);
        
        min_area = min(area_i, area_j);
        max_area = max(area_i, area_j);
        
        if min_area == area_i
            ban_ind = i;
        else
            ban_ind = j;
        end
        
        overlapRatio = bboxOverlapRatio(bboxes(i,:), bboxes(j,:), 'ratioType', 'Min');
        
        % Ban overlap regions
        if lowerBound <= overlapRatio && overlapRatio <= upperBound
            if min_area <= max_area
                ban = [ban ban_ind];
            end
        end     
       
        % Ban regions which are completely inside another region if their
        % areas are close
        if overlapRatio == 1
            if bboxOverlapRatio(bboxes(i,:),bboxes(j,:)) > IoU
                if min_area <= max_area
                    ban = [ban ban_ind];
                end
            end
        end
        
    end
end

keep = 1:num;
keep(unique(ban)) = [];

end