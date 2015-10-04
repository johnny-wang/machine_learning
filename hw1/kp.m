function [ v ] = kp( d, t )
%   KP Kernel / Featurized Perceptron algorithm
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
% Run nonlinear transformation of data, or perform kernel tricks to distinguish 
% (class 2: Red) and (class 3: Green).

class_xy = [];        % var holder should be (m x 2)
class_label = [];     % var holder should be (m x 1)
v = zeros(size(t,1),1);  % to return (m x 1)

%%%%% training prep

% for removing the class 1 stuff
row_idx = find(d(:,3) > 1);
class_xy = d(row_idx, :);     % make a copy of training data
class_label = class_xy(:,end); % separate label to another vector (indexed the same)

% change class 2 labels to +1 and class 3 to -1
row_idx = find(class_label(:,end) == 2);
class_label(row_idx,:) = 1;
row_idx = find(class_label(:,end) == 3);
class_label(row_idx,:) = -1;

%class_xy(:,end) = 1;          % last column = 1 so we can multiply with weight vec
class_xy = class_xy(:,1:2);    % only keep x,y of each training point

a = zeros(size(class_xy, 1), 1);  % number of mistakes


%%%%% training
for i=1:size(class_xy,1)
  xy_sign = 0; 
  for j=1:size(class_xy,1)
    p = a(j) * class_label(j) * gaussian_kernel(class_xy(j,:), class_xy(i,:));
    xy_sign = xy_sign + p;
  end
  
%  xy_sign = sign(sum(a .* class_label .* gaussian_kernel(class_xy, class_xy(i,:))));
%  xy_sign = sum(a .* class_label .* gaussian_kernel(class_xy, class_xy(i,:)));

  xy_sign = sign(xy_sign);
  
  % this only runs at the first iteration; arbitrarily pick 1 or -1
  if xy_sign == 0
    xy_sign = 1;
  end
  
  if xy_sign != class_label(i)
    a(i) = a(i) + 1;
  end 
end

% plot
%figure
%contour(class_xy);
%[x,y] = meshgrid(class_xy(:,1), class_xy(:,2));
%z = peaks(x,y);
%contour(x,y)

%figure
%class_label2 = 2 * ones(size(class_label(find(class_label==1))), 1);
%class_label3 = 3 * ones(size(class_label(find(class_label==1))), 1);

%class2_x = class_xy(find(class_label==1), 1);
%class2_y = class_xy(find(class_label==1), 2);
%scatter3(class2_x, class2_y, class_label2, 'r');

%hold on
%class3_x = class_xy(find(class_label==-1), 1);
%class3_y = class_xy(find(class_label==-1), 2);
%scatter3(class3_x, class3_y, class_label3, 'g');

%xlabel('x');
%ylabel('y');
%zlabel('Class Label');

%%%%% testing

% Create point array for x, y, z of test data points
test_pts = zeros(size(t,1), size(t,2)+1);

for i=1:size(t,1)
  test_pts(i,1:2) = t(i,:);

  predict = 0;
  for j=1:size(class_xy,1)
    p = a(j) * class_label(j) * gaussian_kernel(class_xy(j,:), t(i,:));
    predict = predict + p;
  end
  test_pts(i,3) = predict;
  predict = sign(predict);
%  predict = sign(sum(a .* class_label .* gaussian_kernel(class_xy, pad_t(i,:))));
  if predict == 1
    v(i) = 2;
  else
    v(i) = 3;
  endif
end

%[X,Y] = meshgrid(test_pts(:,1), test_pts(:,2));
%Z = peaks(X,Y);
%contour(test_pts)
%surf(test_pts)

%hold on
%scatter3(test_pts(:,1), test_pts(:,2), test_pts(:,3))

%%%%% Graphing


end
