function [pop, road] = initialise(popsize, stringlength)
    pp = randperm(8, 2); road.src = pp(1); road.dest = pp(2);
    % randomly determine initial population
    emp.gene = [];emp.x1=[];emp.x2=[];emp.fit=[];
    pop=repmat(emp,popsize,1);
    for i = 1:popsize
        pop(i).gene = randperm(stringlength);
    end
    
    % calculate value of x and store in pop.x1 and pop.x2 variable
    % find path
    for i = 1:popsize
        path = (pop(i).gene==road.src | pop(i).gene==road.dest);
        index  = find(path, 8);
        % record path
        path1 = []; path2 = [];
        for subindex = 1:stringlength
            if subindex<=index(2) && subindex>=index(1)
                [path1] = [path1 pop(i).gene(subindex)];
            else
                [path2] = [path2 pop(i).gene(subindex)];
            end
        end
        pop(i).x1 = [0 path1 0];
        pop(i).x2 = [0 path2 0];
    end

    % calculate function value and store in pop.fit variable
    for i = 1:popsize
        size1 = size(pop(i).x1,2);
        size2 = size(pop(i).x2,2);
        distance1 = 0; distance2 = 0;
        for s1_1 = 1:(size1-1)
            s1_2 = s1_1+1;
            distance1 = distance1 + cal_distance(pop(i).x1(s1_1), pop(i).x1(s1_2));
        end
        for s2_1 = 1:(size2-1)
            s2_2 = s2_1+1;
            distance2 = distance2 + cal_distance(pop(i).x2(s2_1), pop(i).x2(s2_2));
        end
        pop(i).fit = distance1+distance2;
    end
end