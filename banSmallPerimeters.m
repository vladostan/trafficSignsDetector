function keep = banSmallPerimeters(bboxes)

% Ban small perimeter regions

ban = [];

perimeters = 2*(bboxes(:,3) + bboxes(:,4));
max_perimeter = max(perimeters);

num = size(bboxes,1);

for i = 1:num
    if perimeters(i) < max_perimeter/20
        ban = [ban i];
    end
end

keep = 1:num;
keep(unique(ban)) = [];

end