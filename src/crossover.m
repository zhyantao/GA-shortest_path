function [child1, child2] = crossover(parent1, parent2, pc, stringlength, road)
    if (rand<pc)
        % determine site for single point crossover
        cpoint = randi([1 stringlength]);
        % perform crossover
        child1.gene = [parent1.gene(:,1:cpoint) parent2.gene(:,cpoint+1:stringlength)];
        child2.gene = [parent2.gene(:,1:cpoint) parent1.gene(:,cpoint+1:stringlength)];
        child1.gene = Unique(child1.gene,1:cpoint);
        child2.gene = Unique(child2.gene,1:cpoint);
        
        % update value of x after crossover in the variable child.xx
        path = (child1.gene==road.src | child1.gene==road.dest);  % variable child1
        index  = find(path, 8);
        % record path
        path1 = []; path2 = [];
        for subindex = 1:stringlength
            if subindex<=index(2) && subindex>=index(1)
                [path1] = [path1 child1.gene(subindex)];
            else
                [path2] = [path2 child1.gene(subindex)];
            end
        end
        child1.x1 = [0 path1 0]; % recording
        child1.x2 = [0 path2 0];
        path = (child2.gene==road.src | child2.gene==road.dest); % variable child2
        index  = find(path, 8);
        % record path
        path1 = []; path2 = [];
        for subindex = 1:stringlength
            if subindex<=index(2) && subindex>=index(1)
                [path1] = [path1 child2.gene(subindex)];
            else
                [path2] = [path2 child2.gene(subindex)];
            end
        end
        child2.x1 = [0 path1 0];
        child2.x2 = [0 path2 0];
        
        % update function value and store in the variable child.fit
        size1 = size(child1.x1,2);
        size2 = size(child1.x2,2);
        distance1 = 0; distance2 = 0;
        for s1_1 = 1:(size1-1)
            s1_2 = s1_1+1;
            distance1 = distance1 + cal_distance(child1.x1(s1_1), child1.x1(s1_2));
        end
        for s2_1 = 1:(size2-1)
            s2_2 = s2_1+1;
            distance2 = distance2 + cal_distance(child1.x2(s2_1), child1.x2(s2_2));
        end
        child1.fit = distance1+distance2;
        size1 = size(child2.x1,2);
        size2 = size(child2.x2,2);
        distance1 = 0; distance2 = 0;
        for s1_1 = 1:(size1-1)
            s1_2 = s1_1+1;
            distance1 = distance1 + cal_distance(child2.x1(s1_1), child2.x1(s1_2));
        end
        for s2_1 = 1:(size2-1)
            s2_2 = s2_1+1;
            distance2 = distance2 + cal_distance(child2.x2(s2_1), child2.x2(s2_2));
        end
        child2.fit = distance1+distance2;
    else
        child1 = parent1;
        child2 = parent1;
    end
end