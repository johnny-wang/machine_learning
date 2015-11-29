
% 10601A/SV-F15: Introduction to Machine Learning
% Programming Assignment 3: Support Vector Machine with Newton's Method
%
% TASK 2: Write a routine that implements Newton's Method 
% 			 to solve dual-form support vector machine.
% ============================================================ 
% INPUT   K: the kernel matrix;
%         C: a column vector that contains the upper bounds; 
%         params: 
%				params.epsilon: the solution accuracy;
% 				params.maxiter: the maximum number of iterations;
%           params.barrier: the multiplicative factor. 
% ============================================================ 
% OUTPUT  alpha: a column vector that contains the optimal coefficients. 

function alpha = svm(K, C, params)
	alpha = zeros(size(K, 1), 1);
    
    % Get average of diagonal of K
    k_avg = trace(K)/size(K,1);    
    
    % Initialization
    a = C / 2;
    mu = 1000 * k_avg;
    i = 0;
    beta = 0.667;
    
    flag = true;
       
    while flag
        % Compute the gradient and the Hessian matrix    
        g = K * a - 1 - (mu * (1 ./ a) - mu * (1 ./ (C-a)));                  
        H = K + diag(mu * (1 ./ (a.^2))) + diag(mu * (1 ./ (C-a).^2));

        % Compute the Newton direction
        d = -H \ g;       

        % Update the iterator counter
        i = i + 1;
        t = 1;    

        % Perform backtracking line search        
        left_val = objective_function(a + t * d, K, mu, C);
        right_val = objective_function(a, K, mu, C) + 0.5 * t * g' * d;
        while left_val > right_val
            t = t * beta;
            left_val = objective_function(a + t * d, K, mu, C);
            right_val = objective_function(a, K, mu, C) + 0.5 * t * g' * d;
        end

        % Update the barrier parameter
        if t > 0.99 && mu > params.epsilon
            mu = mu * params.barrier;
        end
        
        a = a + t * d;                
                
        if (norm(d) <= params.epsilon && mu <= params.epsilon) || (i >= params.maxiter)
            flag = false;
        end
    end
    alpha = a;
end
