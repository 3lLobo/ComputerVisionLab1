function [av_precision] =  av_precision(sorted_labels, class_id)
%% Calculate average precision.
    bin_labels = sorted_labels == class_id;
    f = 0;
    a_sum = 0; 
    for i=1:size(bin_labels)
        f = f+bin_labels(i);
        a_sum = a_sum + bin_labels(i)*(f/i);        
    end
    av_precision = a_sum/f;
end
