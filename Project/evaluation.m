function [classifier_idx_lists, mean_av_prec] = evaluation(test_hists,test_labels,classifiers,class_idx)
% Qualitative & Quantitative evaluation of the classifiers.
     
    % Qualitative: Get lists with top images for each classifier.
    classifier_idx_lists = [];
    
    % classify each test image histogram with each classifier 
    for i=1:size(classifiers,2)
        
        % classify all test images    
        classifier = classifiers{i};
        [~, scores] = predict(classifier, test_hists);
        pos_scores = scores(:,2);
        
        % sort in descending order based on the classification score
        [~,sorted_idx] = sort(pos_scores, 'descend');
        
        % Qualitative: sorted image classification score
        classifier_idx_lists = [classifier_idx_lists; sorted_idx];
        
        % Quantitative: calculate average precision
        av_prec = av_precision(test_labels(sorted_idx), class_idx(i));

    end
    mean_av_prec = mean(av_prec);
end
