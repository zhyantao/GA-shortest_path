%
% Genetic algorithm for Shortest path problem
%

function [optimized_path] = GA(stringlength, ngenerations, popsize)
    
    emp.gene = [];emp.x1=[];emp.x2=[];emp.fit=[];
    optimized_path = repmat(emp,popsize,1);
    
    % params
    pc = 0.95;      % probability of crossover
    pm = 0.05;      % probability of mutation

    % evolution
    gen = 1;
    while gen <= ngenerations
        % initialize population
        [pop, road] = initialise(popsize, stringlength);
        
        % crossover
        pop = pop(randperm(popsize));       % randomize mating pool
        for i = 1 : popsize/2
           parent1index = i;
           parent2index = popsize - (i-1);
           [pop(parent1index),pop(parent2index)] = crossover(pop(parent1index),pop(parent2index),pc, stringlength, road);
        end
        
        % mutation
        for j = 1 : popsize 
            pop(j) = mutation(pop(j),pm, road, stringlength);
        end
        
        % selection
        pop = roulette(pop, popsize);
        gen = gen + 1;

    end
    
    opti_tmp = [];
    [opti_tmp] = [opti_tmp pop(1:popsize).fit];
    index = find(opti_tmp == min(opti_tmp));
    optimized_path = pop(index(1));

end