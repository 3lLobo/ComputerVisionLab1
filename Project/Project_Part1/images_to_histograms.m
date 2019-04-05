function hists = images_to_histograms(images, visual_words, img_type, sift_type)
%% Transform multiple images to histograms of visual words.
    hists = zeros(size(images,1),size(visual_words,2));    
    for i = 1:size(images, 1)
        img = images(i, :);
        image_histogram = img2hist(img, visual_words, img_type, sift_type);
        hists(i,:) = image_histogram;
    end
end
