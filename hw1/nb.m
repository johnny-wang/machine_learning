%
% Johnny Wang, 2015

function [ v ] = nb( d, t )
%   Naive Bayes algorithm
%   d = reference to the n x 3 training dataset  (105 x 3)
%   t = reference to the m x 2 testing dataset   (30 x 2)

%%%%% Input:
% Training dataset
% col1 = sepal length; col2 = sepal width; col3 = labels
% labels = {1,2,3} for i=1,2,..,n

% Testing dataset
% col1 = sepal length; col2 = sepal width;

%%%%% Output
% v: m x 1 for prediction. v={1,2} for i=1,2,..,m

%%%%% Goal
% Implement Gaussian Naive Bayes Classifier to discriminate the class Iris-setosa
% (class 1: Blue) and Iris-versicolor (class 2: Red).

num_classes = 2;
class_mean = zeros(num_classes,2);    % X, Y mean for each class
class_var  = zeros(num_classes,2);    % X, Y variance for each class
train_prior = zeros(num_classes,1);   % prior of each class (num data / total data)
total_data = 0;                       % sum up total data from classes later
v = zeros(size(t, 1),1);              % initialize what we're returning

%%%%% Calculate the mean of each class
for class=1:num_classes
  row_idx = find(d(:,3)==class);      % rows that have the same class label
  [num_rows num_cols] = size(d(row_idx, :));
  sum_rows = sum(d(row_idx, :));
  class_mean(class, :) = sum_rows(:,1:2)/num_rows;   % ignore the last column (class label)
  
  total_data += num_rows;
end

%%%%% Calculate the variance of each class
for class=1:num_classes
  row_idx = find(d(:,3)==class);  % row sthat have the same class label
  [num_rows num_cols] = size(d(row_idx, :));
  diff = (d(row_idx, 1:2) - class_mean(class, :));  % diff of element and mean
  sum_sq_diff = sum(diff .* diff);  % sum all rows of diffs
  class_var(class, :) = sum_sq_diff/num_rows;

  % calculate prior here just because we have num data points per class
  train_prior(class) = num_rows/total_data;
end

class_mean;
class_var;

%%%% classify test data
for i=1:size(t,1)
  test_data = t(i,:);
  
  highest_prob = 0; % temp variable to compare probabilities
  est_class = 1;    % estimated class
  for class=1:num_classes
    prob_x = 1/(sqrt(2*pi*class_var(class,1))) ...
              * exp(-(test_data(1)-class_mean(class,1))^2/2*class_var(class,1));
    prob_y = 1/(sqrt(2*pi*class_var(class,2))) ...
              * exp(-(test_data(2)-class_mean(class,2))^2/2*class_var(class,2));
    prob = prob_x * prob_y * train_prior(class);

    if prob > highest_prob
      highest_prob = prob;
      est_class = class;
    end    
    
  end
  v(i) = est_class;
  
end

end