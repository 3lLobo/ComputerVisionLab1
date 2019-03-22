function [class_svms]=train_svms(X, y, svm_train_data_ratio, class_idx)
%% Train binary SVMs, one for each class in class_idx.
    class_svms= {};
    for i=1:size(class_idx, 2)

        % Get training data for binary SVM
        class_id = class_idx(i);
        
        % Option for using less training data for SVMs
        [svm_X, svm_y] = svm_training_data(X,...
                                           y,... 
                                           class_idx,...
                                           class_id,...
                                           svm_train_data_ratio);
         
        
        % Train SVM with RBF kernel
        svm = fitcsvm(svm_X,...
                      svm_y,...
                      'KernelFunction','RBF',...
                      'Standardize',true,...
                      'KernelScale','auto');
                  
        class_svms{i} = svm;
    end 
end

