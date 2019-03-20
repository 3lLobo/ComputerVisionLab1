function [X_vocab, X_hist, y_hist] = divide_training_data(X,y,class_idx)
%% Divide training data in 2 parts of size 2/5 and 3/5. Both parts consist 
%  of datapoints of different classes to equal parts.

    % get 200 training images from every class to build vocabulary (codebook)
    vocab_build_idx = [];
    dict_build_idx = [];
    for i = class_idx
        inx_range = 1:size(y, 1);
        idx = y == i;
        class_obs = inx_range(idx);
        vocab_build_idx = [vocab_build_idx class_obs(1:200)];
        dict_build_idx = [dict_build_idx class_obs(201:500)];
    end
    % Data to build visual vocabulary
    X_vocab = X(vocab_build_idx, :);
    % Remaining training data
    X_hist =  X(dict_build_idx, :);
    y_hist =  y(dict_build_idx, :);
end