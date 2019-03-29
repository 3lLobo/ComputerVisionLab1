%% Using matlabs Tsne implementation to visualize the feature space
function apply_tsne(nets, data, already_extracted, expdir)

nets.pre_trained.layers{end}.type = 'softmax';
nets.fine_tuned.layers{end}.type = 'softmax';

if ~already_extracted(1)
    feature_data_pre = extract_features(data, nets.pre_trained);
    feature_data_fine = extract_features(data, nets.fine_tuned);

    save('data/features_pretrained.mat', 'feature_data_pre');
    save(fullfile(expdir, 'features_finetuned.mat'), 'feature_data_fine');
end

feature_data_pretrained = load('data/features_pretrained.mat');
feature_data_pretrained = feature_data_pretrained.feature_data_pre;

feature_data_finetuned = load(fullfile(expdir, 'features_finetuned.mat'));
feature_data_finetuned = feature_data_finetuned.feature_data_fine;

if ~already_extracted(2)
    [tsne_Y_pt, tsne_loss_pt] = tsne(feature_data_pretrained.features, 'Standardize', true);
    save('data/tsne_pretrained.mat', 'tsne_Y_pt');
    
    [tsne_Y_ft, tsne_loss_ft] = tsne(feature_data_finetuned.features, 'Standardize', true);
    save(fullfile(expdir, 'tsne_visualization.mat'), 'tsne_Y_ft');
end

tsne_Y_pt = load('data/tsne_pretrained.mat');
tsne_Y_ft = load(fullfile(expdir, 'tsne_visualization.mat'));

tsne_Y_pt = tsne_Y_pt.tsne_Y_pt;
tsne_Y_ft = tsne_Y_ft.tsne_Y_ft;

figure;
subplot(1,2,1)
gscatter(tsne_Y_pt(:,1), tsne_Y_pt(:,2), feature_data_pretrained.labels)
subplot(1,2,2)
gscatter(tsne_Y_ft(:,1), tsne_Y_ft(:,2), feature_data_finetuned.labels)
 
 end