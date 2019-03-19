function [cluster_centers, vocab_data_X, dict_data_X, dict_y] = build_visual_vocab(X_train, y_train, class_idx, number_clusters)

% get 250 training images from every class to build vocabulary (codebook)
vocab_build_idx = [];
dict_build_idx = [];
for i = class_idx
    inx_range = 1:size(y_train, 1);
    idx = y_train == i;
    class_obs = inx_range(idx);
    vocab_build_idx = [vocab_build_idx class_obs(1:200)];
    dict_build_idx = [dict_build_idx class_obs(201:500)];
end
vocab_data_X = X_train(vocab_build_idx, :);
dict_data_X = X_train(dict_build_idx, :);
dict_y = y_train(dict_build_idx, :);

%build visual vocabulary
vocab_features = extract_features(vocab_data_X, "gray");
vocab_features_dt = transpose(double(vocab_features));
[cluster_centers, ~] = vl_kmeans(vocab_features_dt, number_clusters);

end