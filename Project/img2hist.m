function image_hist = img2hist(img, visual_words,img_type,sift_type)
%% Transform image to histogram of given visual words.

    num_vw = size(visual_words, 2);

    % get SIFT descriptors of image
    descriptors = ext_from_single_obs(img, img_type, sift_type);

    %for each descriptor: see which visual word it is closest to
    [~, K] = min(transpose(vl_alldist2(transpose(double(descriptors)), visual_words)));

    % count closest descriptors per visual word (= create histogram)
    image_hist = histcounts(K, 1:num_vw+1);

    % normalize histogram
    image_hist = image_hist / size(descriptors, 1);
end