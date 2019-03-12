im_left = imread('left.jpg');
im_right = imread('right.jpg');

imshow(im_right)

N = 50;
K = 10;

%run vlfeat/toolbox/vl_setup

stitch(im_left, im_right, N, K);

%figure;
%imshow(stitched_image);