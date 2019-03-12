function [] = harris_demo()

I_pt = imread('person_toy/00000001.jpg');
I_pt_gray = rgb2gray(I_pt);
I_pt_gd = im2double(I_pt_gray);

I_pp = imread('pingpong/0000.jpeg');
I_pp_gray = rgb2gray(I_pp);
I_pp_gd = im2double(I_pp_gray);

% Exercise 1.1 and 1.2 // comment one of both in
% 'person_toy' image 
[H, r, c] = harris_corner_detection(I_pt_gd, 0.005);
% 'pingpong' image
%[H, r, c] = harris_corner_detection(I_pp_gd, 0.005);

% Exercise 1.3
Ipt_45 = imrotate(I_pt_gd, 45);
[~, r_45, c_45] = harris_corner_detection(Ipt_45, 0.005, false);

Ipt_90 = imrotate(I_pt_gd, 90);
[~, r_90, c_90] = harris_corner_detection(Ipt_90, 0.005, false);

figure(2);
subplot(1,2,1)
imshow(Ipt_45);
hold on;
plot(c_45, r_45, 'r*', 'LineWidth', 3, 'MarkerSize', 3);
mt(1) = title('Rotated 45 degrees', 'fontsize', 25);
subplot(1,2,2)
imshow(Ipt_90);
hold on;
plot(c_90, r_90, 'r*', 'LineWidth', 3, 'MarkerSize', 3);
mt(2) = title('Rotated 90 degrees', 'fontsize', 25);


end
