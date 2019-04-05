%% main function
clear

%% Here we load the pretrained and a finetuned model for visualization and calculating accuracy.  

%% fine-tune cnn (see if model is trained the wanted number of epochs)
epoch = 40;
b_size = 50;
id = "_e_" + epoch + "_b_" +b_size;
[net, info, expdir] = finetune_cnn(epoch, b_size, id);

%% extract features and train svm
nets.fine_tuned = load(fullfile(expdir, 'net-epoch-40.mat'));
nets.fine_tuned = nets.fine_tuned.net;

nets.pre_trained = load(fullfile('data', 'pre_trained_model.mat'));
nets.pre_trained = nets.pre_trained.net; 

data = load(fullfile(expdir, 'imdb-stl.mat'));

%% Visualize with tsne
% Two booleans for the visualization.
% First, already features extracted, Second: already Tsne calculated
already_extracted = [false, false];
apply_tsne(nets, data, already_extracted, expdir)

%% This function compares the accuracy of the CNN and SVM
% train_svm(nets, data);
