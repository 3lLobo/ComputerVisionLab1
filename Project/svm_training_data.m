function [svm_X, svm_y] = svm_training_data(X,y,class_idx,class_id,num_pos)
%% Create training data for single SVM.
    
    num_classes = size(class_idx,2);
    x_range = 1:size(X,1);

    svm_X = [];
    % get num_pos positive data samples   
    pos_idx = x_range((y == class_id));
    pos_sample_idx = datasample(pos_idx,num_pos,'Replace',false);
    pos_hists = X(pos_sample_idx, :);
    svm_X = [svm_X; pos_hists];
    
    % get num_pos negative data samples from each remaining class
    for i= 1:num_classes
        c = class_idx(i);
        if not(c==class_id)
            neg_idx = x_range((y==c));
            neg_sample_idx = datasample(neg_idx,num_pos,'Replace',false);
            neg_hists = X(neg_sample_idx, :);
            svm_X = [svm_X; neg_hists];
        end    
    end
    
    % create binary y
    % note: positive data samples always at the beginning
    svm_y = zeros(num_classes*num_pos,1);
    svm_y(1:num_pos)=1;
end 