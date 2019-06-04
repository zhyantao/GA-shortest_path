clc; clear;

precision = 8;                      % binary string length
ngenerations = 100;                 % number of iterations
npop = 40;                          % population size

emp.gene = [];emp.x1=[];emp.x2=[];emp.fit=[];
optimized_path = repmat(emp,10,1);
perfect_path = repmat(emp,1,1);
perfect_path.fit = Inf;

% run the algorithm 50 times
for i = 1:50
    [optimized_path(i)] = GA(precision, ngenerations, npop);
    % if NOT satisfy the meaning , unvalid generation
    weight1 = cal_weight(optimized_path(i).x1);
    weight2 = cal_weight(optimized_path(i).x2);
    if (weight1 ~= 0) && (weight2 ~= 0) && (weight1 <= 8) && (weight2 <= 8) ...
            && (optimized_path(i).fit < perfect_path.fit)
        perfect_path = optimized_path(i);
    end
end

% print the results
path1 = perfect_path.x1;
fprintf('小车1的行走路线为：');
for i = 1 : size(path1, 2)
    if i > 1 && i <= size(path1, 2)
        fprintf(' -> ');
    end
    fprintf('%d', path1(i));
end
fprintf('\n');
path2 = perfect_path.x2;
fprintf('小车2的行走路线为：');
for i = 1 : size(path2, 2)
    if i > 1 && i <= size(path2, 2)
        fprintf(' -> ');
    end    
    fprintf('%d', path2(i));
end
fprintf('\n两辆车行驶的总距离为： %.2f km \n', perfect_path.fit);