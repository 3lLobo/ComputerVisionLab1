function [X_train, y_train, class_idx] = load_data(path, classes_used)
%% Load datapoints of classes we want to use.

% load data 
load(path);
X_train = X;
y_train = y;
clear fold_indices

% filter data such that it only contains classes we use
class_idx = 1:10;
log_idx = ismember(class_names, classes_used);
class_idx = class_idx(log_idx);
class_select = ismember(y_train, class_idx);
X_train = X_train(class_select, :);
y_train = y_train(class_select, :);
end
