function c = subgraphConnections(src,dest)
if numel(src) > 1
    dest_name_root = [dest.Name '/in'];
    tmp = cell(numel(src),2);
    for k = 1:numel(src)
        tmp{k,1} = src(k).Name;
        tmp{k,2} = [dest_name_root num2str(k)];
    end
elseif numel(dest) > 1
    tmp = cell(numel(dest),2);
    for k = 1:numel(dest)
        tmp{k,1} = src.Name;
        tmp{k,2} = dest(k).Name;
    end
end
c = table(tmp(:,1),tmp(:,2),'VariableNames',{'Source','Destination'});
end