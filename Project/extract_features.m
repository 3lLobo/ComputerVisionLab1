function features = extract_features(X, type)
    
N = size(X, 1);
features = [];

for i = 1:N
    obervation = X(i, :);
    descriptors = ext_from_single_obs(obervation, type);
    features = [features ; descriptors];
 
end
    
end