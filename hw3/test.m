 

K = randn(100) * 10;
C = ones(size(K,1),1);
param = struct('maxiter', 5, 'epsilon', 1e-6, 'barrier', 0.2)

svm(K, C, param)
