% Task 3 Plot the decision boundary using the SVM developed in Task 2 and
% the given Iris dataset.
%% Initialization - read files and init features / label
data = csvread('iris.csv');

num_data = size(data,1);        % d
data_feat = ones(num_data,3);   % N x 3; last column is intercept of 1's
data_feat(:,1:2) = data(:,1:2); % features are only the first 2 columns
data_label = data(:,3);

size(data_feat)
size(data_label)

%% Create Kernel

K = zeros(num_data, num_data);  % d x d

for i=1:num_data
    for j=1:num_data
        K(i,j) = data_label(i) * data_label(j) * data_feat(i,:) * data_feat(j,:)';
    end
end

%% Setup SVM

C = ones(num_data, 1);
param = struct('maxiter', 75, 'epsilon', 1e-6, 'barrier', 0.2)

%% Run SVM
alpha = svm(K, C, param);

%% Plot
% plot data points
ones_idx = find(data_label==1);
scatter(data_feat(ones_idx,1), data_feat(ones_idx,2), 'r');
hold on;
neg_idx = find(data_label==-1);
scatter(data_feat(neg_idx,1), data_feat(neg_idx,2), 'g');

% plot weight vector
weight_vec = 0;
for i=1:num_data
    weight_vec = weight_vec + alpha(i) * data_feat(i,:) * data_label(i);
end
weight_vec

x = 4:0.1:7;
plot(x, x*(-weight_vec(1)/weight_vec(2)) - weight_vec(3)/weight_vec(2));
xlabel('Sepal Length');
ylabel('Sepal Width');
title('Decision Boundary of Iris Setosa vs Iris Versicolor');

