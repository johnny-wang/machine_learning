function [ v ] = lp( d, t )
%   LP Linear Perceptron algorithm
%   d = reference to the n x 3 training dataset  (105 x 3)
%   t = reference to the m x 2 testing dataset   (30 x 2)

%%%%% Input:
% Training dataset
% col1 = sepal length; col2 = sepal width; col3 = labels
% labels = {1,2,3} for i=1,2,..,n

% Testing dataset
% col1 = sepal length; col2 = sepal width;

%%%%% Output
% v: m x 1 for prediction. v={2,3} for i=1,2,..,m

%%%%% Goal
% Implement a linear perceptron to distinguish (class 2: Red) and (class 3: Green).


step_size = 0.005;    % need to tune step size
w_vec = [0 1 0];      % weight vector

class_xy = [];        % var holder should be (m x 2)
class_label = [];     % var holder should be (m x 1)
v = zeros(size(t,1),1);  % to return (m x 1)

%%%%% training prep

% for removing the class 1 stuff
row_idx = find(d(:,3) > 1);
class_xy = d(row_idx, :);       % make a copy of training data
class_label = class_xy(:,end);  % separate label to another vector (indexed the same)

% change class 2 labels to +1
row_idx = find(class_label(:,end) == 2);
class_label(row_idx,:) = 1;

% plot class 2 xy
figure
scatter(class_xy(row_idx, 1), class_xy(row_idx, 2), 'r')

% change class 3 labels to -1
row_idx = find(class_label(:,end) == 3);
class_label(row_idx,:) = -1;

% plot class 3 xy
hold on
scatter(class_xy(row_idx, 1), class_xy(row_idx, 2), 'g')

                              
class_xy(:,end) = 1;          % last column = 1 so we can multiply with weight vec

%%%%% training
for i=1:size(class_xy,1)
  xy_sign = sign(w_vec * class_xy(i,:)');
  if xy_sign != class_label(i)
    w_vec = w_vec + class_label(i) .* class_xy(i,:) .* step_size;
    w_vec = w_vec/norm(w_vec);
  end
end

w_vec

% plot weight vector line
hold on
m = w_vec(2)/w_vec(1);
x = 0:0.1:10;
plot(x, x*(-w_vec(1)/w_vec(2)));

xlabel('x');
ylabel('y');
title('Training Data');
legend('Class 2', 'Class 3');

%%%%% classify test data

% add 3rd column so it'll multiply correctly with weight vector
pad_t = [t, zeros(size(t,1),1)];

for i=1:size(pad_t,1)
  predict = sign(w_vec * pad_t(i,:)');
  if predict == 1
    v(i) = 2;
  else
    v(i) = 3;
  endif
end

figure
scatter(pad_t(:, 1), pad_t(:, 2), 'b')
hold on
m = w_vec(2)/w_vec(1);
x = 0:0.1:10;
plot(x, x*(-w_vec(1)/w_vec(2)));
xlabel('x');
ylabel('y');
title('Test Data');

end

