function weight = cal_weight(path)
    % calculate weight
    g = [1 2 1 2 1 4 2 2];
    weight = 0;
    for i = 1:8
        if find(path==i)~=1 & find(path==i)~=size(path,2)
            weight = weight + g(i);
        end
    end
end