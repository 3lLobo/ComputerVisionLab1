function features = extract_features(X, type, sift_type)
    
N = size(X, 1);
features = [];

for i = 1:N
    obervation = X(i, :);
    descriptors = ext_from_single_obs(obervation, type, sift_type);
    features = [features ; descriptors];
 
end
    
end