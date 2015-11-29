function [ ret_val ] = objective_function( alpha, K, mu, C )
% Objective function for the backtracking line search
%   alpha: weights of the SVM we're trying to calculate
%   K: the kernel matrix;
%   mu: barrier parameter that regulates how much we pay attention to
%       objective function vs. barrier terms.
%   C: a column vector that contains the upper bounds; 

    % Make sure alpha is within feasible range
    if all(alpha >= 0) && all((alpha <= C))        
        ret_val = 0.5 * alpha' * K * alpha - sum(1 .* alpha) - ( ...
            (mu * sum(1 .* log(alpha))) + (mu * sum(1 .* log(C - alpha))));
    else        
        ret_val = inf;
    end
    
end