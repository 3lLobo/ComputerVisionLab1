function [mean_av_prec,av_prec, mean_acc, accs] = evaluation(test_images,test_hists,test_labels,classifiers,...
    class_idx,run_path)
% Qualitative & Quantitative evaluation of the classifiers.
     
    % Qualitative: Get lists with top images for each classifier.
    
    % classify each test image histogram with each classifier 
    for i=1:size(classifiers,2)
        
        % classify all test images    
        classifier = classifiers{i};
        [pred, scores] = predict(classifier, test_hists);
        pos_scores = scores(:,1);
        
        % calculate accuracy
        true_binary = test_labels==class_idx(i);
        accs(i) = sum(pred == true_binary)/length(pred);
        
        % sort in descending order based on the classification score
        [~,sorted_idx] = sort(pos_scores);
        
        % Qualitative: save top 5 images and bottom 5 images
        top_images{i} = test_images(sorted_idx(1:5),:);
        bottom_images{i} = test_images(sorted_idx(end-4:end),:);
        
        % quantitative: calculate average precision
        av_prec(i) = av_precision(test_labels(sorted_idx), class_idx(i));

    end
    
    mean_av_prec = mean(av_prec);
    mean_acc = mean(accs);
    
    % save top/bottom images to file:
    save(run_path+'classifiers.mat', 'classifiers')
    save_images(run_path+"top.png", top_images);
    save_images(run_path+"bottom.png", bottom_images);
    
end
