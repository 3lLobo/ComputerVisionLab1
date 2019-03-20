function [svms]=train_svms(X, y, num_pos, class_idx, kernel_types)
%% Train binary SVMs, one for each class in class_idx.
    for i=1:size(class_idx, 2)

        % Get training data for binary SVM
        class_id = class_idx(i);
        [svm_X, svm_y] = svm_training_data(X,...
                                           y,... 
                                           class_idx,...
                                           class_id,...
                                           num_pos);
                                       
        % Train SVM for different kernel types 
        % & decide on training_acc
        acc = 0
        for k=1:size(kernel_types,2)  
            k_type = kernel_types(k);
            % Check accuracy with cross-validation      
            % Task: "for proper SVM scores you need to use cross-validation 
            % to get a proper estimate of the SVM parameters"
            acc_kernel = svmtrain(svm_y, svm_X, sprintf('-t %d -q -w1 4 -v 5', k_type));
            if acc_kernel>=acc
                model = svmtrain(svm_y, svm_X, sprintf('-t %d -q -w1 4', k_type));
            end
            svms(i) = model;
        end
    end 
end

