%% Rewritten the "get_svm_data" function to serve a more general purpose
function feature_data = extract_features(data, net)

feature_data.features = [];
feature_data.labels = [];

for i = 1:size(data.images.data, 4)
    if(data.images.set(i)==2) 
        res = vl_simplenn(net, data.images.data(:, :,:, i));
        feat = res(end-3).x; feat = squeeze(feat);

        feature_data.features = cat(2, feature_data.features, feat);
        feature_data.labels = cat(1, feature_data.labels, data.images.labels(i));

        % feature_data.features = [feature_data.features feat];
        % feature_data.labels = [feature_data.labels;  data.images.labels(i)];
    end
    
end

feature_data.labels = double(feature_data.labels);
feature_data.features = double(feature_data.features');

end
