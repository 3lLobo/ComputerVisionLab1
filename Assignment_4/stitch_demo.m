%run vlfeat/toolbox/vl_setup

im_left = imread('left.jpg');
im_right = imread('right.jpg');
N = 50;
K = 10;

<<<<<<< HEAD:Assignment_4/stitch_test.m
%run vlfeat/toolbox/vl_setup

img = stitch_2(im_left, im_right, N, K);

=======
% run stitch.m for test images
img = stitch(im_left, im_right, N, K);
>>>>>>> master:Assignment_4/stitch_demo.m
figure;
imshow(img);
