function [newpop] = roulette(oldpop, popsize)
    
    emp.gene = [];emp.x1=[];emp.x2=[];emp.fit=[];
    newpop = repmat(emp,popsize,1);
    
    % calculate total fitness
    opti_tmp = [];
    [opti_tmp] = [opti_tmp oldpop(1:popsize).fit];
    totalfit=sum(opti_tmp);
    % calculate relative fitness
    prob = zeros(popsize,1);
    for i = 1:popsize
        prob(i) = oldpop(i).fit / totalfit;
    end
    % sort by cumulative fitness
    prob = cumsum(prob);
    % generate probabilites for roulette wheel selection
    rns=sort(rand(popsize,1));
    fitin=1;    % index into old population
    newin=1;    % index into new population
    % select new population, keeping population size constant
    while newin <= popsize 
        if (rns(newin) < prob(fitin))
            newpop(newin) = oldpop(fitin);
            newin = newin + 1;
        else
            fitin=fitin+1;
        end
    end
    
end