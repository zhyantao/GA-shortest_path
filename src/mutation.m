function [child] = mutation(parent, pm, road, stringlength)
    if (rand < pm)
        % determine mutation site
        mpoint = randi([1 stringlength]);
        child = parent;
        % flip the bit at mutation point
        child.gene(mpoint) = abs(parent.gene(mpoint)-1);
        
        % update value of x and store in the variable child.xx
        path = (child.gene==road.src | child.gene==road.dest);
        index  = find(path, 8);
        % record path
        path1 = []; path2 = [];
        for subindex = 1:stringlength
            if size(index,2)==2 && subindex<=index(2) && subindex>=index(1)
                [path1] = [path1 child.gene(subindex)];
            else
                [path2] = [path2 child.gene(subindex)];
            end
        end
        child.x1 = [0 path1 0]; % recording
        child.x2 = [0 path2 0];
        
        % update function value and store in the variable child.fit
        size1 = size(child.x1,2);
        size2 = size(child.x2,2);
        distance1 = 0; distance2 = 0;
        for s1_1 = 1:(size1-1)
            s1_2 = s1_1+1;
            distance1 = distance1 + cal_distance(child.x1(s1_1), child.x1(s1_2));
        end
        for s2_1 = 1:(size2-1)
            s2_2 = s2_1+1;
            distance2 = distance2 + cal_distance(child.x2(s2_1), child.x2(s2_2));
        end
        child.fit = distance1+distance2;
        
    else
        child = parent;
    end
end