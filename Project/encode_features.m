function image_hist = encode_features(observation, cluster_centers, c_size,type,sift_type)

descriptors = ext_from_single_obs(observation, type, sift_type);
[~, K] = min(transpose(vl_alldist2(transpose(double(descriptors)), cluster_centers)));
image_hist = histcounts(K, 1:c_size+1);
image_hist = image_hist / size(descriptors, 1);

end