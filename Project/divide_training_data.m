function [X_vocab, X_hist, y_hist] = divide_training_data(X,y,class_idx,split_ratio)
%% Divide training data in 2 parts. 
% Both parts consist of datapoints of different classes to  parts.

    % get 200 training images from every class to build vocabulary (codebook)
    samples_per_class = size(X,1)/size(class_idx,2);
    split_point = floor(samples_per_class*split_ratio);
    
    vocab_build_idx = [];
    dict_build_idx = [];
    for i = class_idx
        inx_range = 1:size(y, 1);
        idx = y == i;
        class_obs = inx_range(idx);
        vocab_build_idx = [vocab_build_idx class_obs(1:split_point)];
        dict_build_idx = [dict_build_idx class_obs(split_point+1:samples_per_class)];
    end
    
    % Data to build visual vocabulary
    X_vocab = X(vocab_build_idx, :);
    % Remaining training data
    X_hist =  X(dict_build_idx, :);
    y_hist =  y(dict_build_idx, :);
end