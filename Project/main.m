clc
clear all
close all

run vlfeat/toolbox/vl_setup

train_path = 'stl10_matlab/train.mat';
test_path = 'stl10_matlab/test.mat';

classes_used = {'airplane', 'bird', 'ship', 'horse', 'car'};

% PARAMS TO TRY OUT:
num_clusters    = 400;      %  400, 1000, 40000
sift_type       = "dense";  % "regular", "dense"
img_type        = "gray";   % "gray", "rgb","opponent"

% SVM params 
svm_num_pos_train_images = 50; % at least 50, max


% Load data.
[X_train, y_train, class_idx] = load_data(train_path,classes_used);
%[X_test, y_test, ~] = load_data(test_path,classes_used);


% Divide training data in two parts: One is used for building the visual
% vocabulary, the other is transformed into histograms of visual words.
[X_train_vocab, X_train_hist, y_train_hist] = divide_training_data(X_train, y_train, class_idx);


% Build visual vocabulary. (Tasks 2.1 and 2.2)
[cluster_centers] =  build_visual_vocab(X_train_vocab,...  
                                        num_clusters,...
                                        img_type,...
                                        sift_type);
                              
% Respresent remaining training data points as collections (=histograms) of
% visual words from the visual vocabulary. (Tasks 2.3 and 2.4)
X_hists =  images_to_histograms(X_train_hist,...
                                cluster_centers,...
                                img_type,...
                                sift_type);
                     
                            
%Train 5 binary SVMs
svms = train_svms(X_hists,...
                  y_train_hist,...
                  svm_num_pos_train_images,...
                  class_idx);


    

% Classify Test Image:
% - Calculate its histogram with global visual words
% - get response from every SVM 
% - assign it to the most probable object class

