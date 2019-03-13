%run vlfeat/toolbox/vl_setup

im_left = imread('left.jpg');
im_right = imread('right.jpg');
N = 50;
K = 10;

%run vlfeat/toolbox/vl_setup

img = stitch(im_left, im_right, N, K, 2);
figure;
imshow(img);
