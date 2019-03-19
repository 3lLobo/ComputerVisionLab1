clc
clear all
close all

run vlfeat/toolbox/vl_setup

load('stl10_matlab/train.mat');
X_train = X;
y_train = y;
clear fold_indices

% Filter clases we use
class_used = {'airplane', 'bird', 'ship', 'horse', 'car'};
class_idx = 1:10;
log_idx = ismember(class_names, class_used);
class_idx = class_idx(log_idx);
class_select = ismember(y_train, class_idx);
X_train = X_train(class_select, :);
y_train = y_train(class_select, :);

% in exercise 400, 1000, 40000
number_clusters = 400;
% 2.1 and 2.2
[cluster_centers, vocab_data_X, dict_data_X, dict_y] = build_visual_vocab(X_train, y_train, class_idx, number_clusters);

% 2.3 and 2.4
X_hists = create_training_data(dict_data_X, cluster_centers, "gray");
              
% We can now train the SVM with X_hists as training vectors and dict_y as
% corresponding labels. 

% TODO: insert possibility to use dense SIFT in "extract features" and
% "ext_from_single_obs". Just one additional parameter and one if else in the
% "ext_from_single_obs" function. Implementation trivial since given at www.vlfeat.org. 

