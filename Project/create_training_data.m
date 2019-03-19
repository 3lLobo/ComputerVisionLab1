function X_hists = create_training_data(dict_data_X, cluster_centers, type)

c_size = size(cluster_centers, 2);

X_hists = [];
for i = 1:size(dict_data_X, 1)
    
    observation = dict_data_X(i, :);
    image_histogram = encode_features(observation, cluster_centers, c_size, type);
    X_hists = [X_hists; image_histogram];

end

end