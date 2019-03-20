function [cluster_centers] = build_visual_vocab(images, vocab_size, img_type, sift_type)
%% Build visual vocubulary of given size from given images.

% get SIFT descriptors for all images
vocab_features = [];
for i = 1:size(images, 1)
    obervation = images(i, :);
    descriptors = ext_from_single_obs(obervation, img_type, sift_type);
    vocab_features = [vocab_features ; descriptors];
end
vocab_features_dt = transpose(double(vocab_features));

% run kmeans on all discriptors to receive visual words (= cluster
% centroids)
[cluster_centers, ~] = vl_kmeans(vocab_features_dt, vocab_size);
end