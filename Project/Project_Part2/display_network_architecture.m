% % 3.1
% 1. Do you observe any pattern in the architecture of the network? 
% If so, describe it in your own words.
% 2. Which part of the network has the most parameters and the biggest size?
net = load('data/pre_trained_model.mat'); 
vl_simplenn_display(net.net);

