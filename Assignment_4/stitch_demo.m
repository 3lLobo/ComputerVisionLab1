%run vlfeat/toolbox/vl_setup

im_left = imread('left.jpg');
im_right = imread('right.jpg');
N = 50;
K = 10;

% run stitch.m for test images
img = stitch(im_left, im_right, N, K);
figure;
imshow(img);
