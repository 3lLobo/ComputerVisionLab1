%% We will perform grid-search to optimize our hyperparameters
function optimize_hyperparams()

epochs = [40, 80, 120];
batch_sizes = [50, 100];

for e_idx = 1:size(epochs, 1)
    epoch = epochs(e_idx);
    for b_idx = 1:size(batch_sizes, 1)
        b_size = batch_sizes(b_idx);
        id = "_e_" + epoch + "_b_" +b_size;
        [net, info, expdir] = finetune_cnn(epoch, b_size, id);
 
    end
end

end