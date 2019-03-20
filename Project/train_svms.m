function [svms]=train_svms(X, y, num_pos, class_idx)
%% Train binary SVMs, one for each class in class_idx.
    % TODO:
    % train SVM (for proper SVM scores you need to use cross-validation to get a proper estimate of
    % the SVM parameters)
    
    for i=1:size(class_idx, 2)

        % Get training data for binary SVM
        class_id = class_idx(i);
        [svm_X, svm_y] = svm_training_data(X,...
                                           y,... 
                                           class_idx,...
                                           class_id,...
                                           num_pos);
        % Train SVM                               
        model = svmtrain(svm_y, svm_X, '-q');
        svms(i) = model;
    end 
end

