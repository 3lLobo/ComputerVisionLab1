im_left = imread('left.jpg');
im_right = imread('right.jpg');


N = 50;
K = 10;

%run vlfeat/toolbox/vl_setup

img = stitch_2(im_left, im_right, N, K);

figure;
imshow(img);

%figure;
%imshow(stitched_image);