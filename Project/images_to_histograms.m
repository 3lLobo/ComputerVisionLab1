function hists = images_to_histograms(images, visual_words, img_type, sift_type)
%% Transform multiple images to histograms of visual words.
    hists = [];
    for i = 1:size(images, 1)
        img = images(i, :);
        image_histogram = img2hist(img, visual_words, img_type, sift_type);
        hists = [hists; image_histogram];
    end
end