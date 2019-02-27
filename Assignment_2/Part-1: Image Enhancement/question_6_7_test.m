% Question 6
im1 = imread('images/image1.jpg');
im1_sp = imread('images/image1_saltpepper.jpg');
im1_gs = imread('images/image1_gaussian.jpg');

% results for question 6
PSNR_sp = myPSNR( im1, im1_sp );
PSNR_gs = myPSNR( im1, im1_gs );

% Question 7.1
current_image = im1_gs;

% Box filtering: 3x3, 5x5, and 7x7.
box3_3 = denoise( current_image, 'box', [3, 3]);
box5_5 = denoise( current_image, 'box', [5, 5]);
box7_7 = denoise( current_image, 'box', [7, 7]);

% Median filtering: 3x3, 5x5 and 7x7.
median3_3 = denoise( current_image, 'median', [3, 3]);
median5_5 = denoise( current_image, 'median', [5, 5]);
median7_7 = denoise( current_image, 'median', [7, 7]);

% plotting results
figure;
subplot(2,3,1)
imshow(box3_3);
mt(1) = title('3x3', 'fontsize', 25);
subplot(2,3,2)
imshow(box5_5);
mt(2) = title('5x5', 'fontsize', 25);
subplot(2,3,3)
imshow(box7_7);
mt(3) = title('7x7', 'fontsize', 25);
subplot(2,3,4)
imshow(median3_3);
subplot(2,3,5)
imshow(median5_5);
subplot(2,3,6)
imshow(median7_7);

% Question 7.2 => needs to be executed twice for two different current_images
psnr_results = zeros(1, 6);
result_list = {box3_3, box5_5, box7_7, median3_3, median5_5, median7_7};
for i = 1:length(result_list)
    denoised_img = result_list{i};
    c_psnr = myPSNR( im1, denoised_img );
    psnr_results(i) = c_psnr;
end

% Question 7.4 => image1 gaussian.jpg using a Gaussian filtering.
% Choose an appropriate window size and standard deviation and justify your choice.

g_denoise_33_05 = denoise( im1_gs, 'gaussian', [3, 3], 0.5);
g_denoise_33_1 = denoise( im1_gs, 'gaussian', [3, 3], 1);
g_denoise_33_2 = denoise( im1_gs, 'gaussian', [3, 3], 2);
g_denoise_55_05 = denoise( im1_gs, 'gaussian', [5, 5], 0.5);
g_denoise_55_1 = denoise( im1_gs, 'gaussian', [5, 5], 1);
g_denoise_55_2 = denoise( im1_gs, 'gaussian', [5, 5], 2);
g_denoise_77_05 = denoise( im1_gs, 'gaussian', [7, 7], 0.5);
g_denoise_77_1 = denoise( im1_gs, 'gaussian', [7, 7], 1);
g_denoise_77_2 = denoise( im1_gs, 'gaussian', [7, 7], 2);

figure(2);
subplot(1,3,1)
imshow(g_denoise_33_05);
mt(1) = title('3x3', 'fontsize', 25);
subplot(1,3,2)
imshow(g_denoise_55_05);
mt(2) = title('5x5', 'fontsize', 25);
subplot(1,3,3)
imshow(g_denoise_77_05);
mt(3) = title('7x7', 'fontsize', 25);

figure(3);
subplot(1,3,1)
imshow(g_denoise_33_1);
subplot(1,3,2)
imshow(g_denoise_55_1);
subplot(1,3,3)
imshow(g_denoise_77_1);

figure(4);
subplot(1,3,1)
imshow(g_denoise_33_2);
subplot(1,3,2)
imshow(g_denoise_55_2);
subplot(1,3,3)
imshow(g_denoise_77_2);

% Question 7.5
g_denoise_33_05 = denoise( im1_gs, 'gaussian', [3, 3], 0.5);
g_denoise_33_10 = denoise( im1_gs, 'gaussian', [3, 3], 1);
g_denoise_33_15 = denoise( im1_gs, 'gaussian', [3, 3], 1.5);
g_denoise_33_20 = denoise( im1_gs, 'gaussian', [3, 3], 2);
g_denoise_33_25 = denoise( im1_gs, 'gaussian', [3, 3], 2.5);
g_denoise_33_30 = denoise( im1_gs, 'gaussian', [3, 3], 3);

sp_denoise_33_05 = denoise( im1_sp, 'gaussian', [3, 3], 0.5);
sp_denoise_33_10 = denoise( im1_sp, 'gaussian', [3, 3], 1);
sp_denoise_33_15 = denoise( im1_sp, 'gaussian', [3, 3], 1.5);
sp_denoise_33_20 = denoise( im1_sp, 'gaussian', [3, 3], 2);
sp_denoise_33_25 = denoise( im1_sp, 'gaussian', [3, 3], 2.5);
sp_denoise_33_30 = denoise( im1_sp, 'gaussian', [3, 3], 3);

g_psnr_results = zeros(1, 6);
g_result_list = {g_denoise_33_05, g_denoise_33_10, g_denoise_33_15, g_denoise_33_20, g_denoise_33_25, g_denoise_33_30};
for i = 1:length(g_result_list)
    denoised_img = g_result_list{i};
    c_psnr = myPSNR( im1, denoised_img );
    g_psnr_results(i) = c_psnr;
end

sp_psnr_results = zeros(1, 6);
sp_result_list = {sp_denoise_33_05, sp_denoise_33_10, sp_denoise_33_15, sp_denoise_33_20, sp_denoise_33_25, sp_denoise_33_30};
for i = 1:length(sp_result_list)
    denoised_img = sp_result_list{i};
    c_psnr = myPSNR( im1, denoised_img );
    sp_psnr_results(i) = c_psnr;
end

g_psnr_results;
sp_psnr_results;

% Question 7.6
% What is the difference among median filtering, box filtering and Gaus-
% sian filtering? Briefly explain how they are different at a conceptual
% level. If two filtering methods give a PSNR in the same ballpark, can
% you see a qualitative difference?

% denoised images with similar PSNR are:

% Box filter: Gaussian noise 5x5 (23.6610)
denoise_box5_5 = denoise( im1_gs, 'box', [5, 5]);
box_psnr = myPSNR( im1, denoise_box5_5 );

% Median filter: Gaussian noise 5x5 (23.7983)
denoise_median5_5 = denoise( im1_gs, 'median', [5, 5]);
median_psnr = myPSNR( im1, denoise_median5_5 );

% Gaussian filter: Gaussian noise 3x3, 1.5 (24.2970)
denoise_g_33_05 = denoise( im1_gs, 'gaussian', [3, 3], 0.5);
denoise_g_33_15 = denoise( im1_gs, 'gaussian', [3, 3], 1.5);
gaussian_psnr = myPSNR( im1, denoise_g_33_05 );
gaussian_psnr2 = myPSNR( im1, denoise_g_33_15 );

figure(5);
subplot(2,2,1)
imshow(denoise_box5_5);
mt(1) = title('Box (23.661)', 'fontsize', 20);
subplot(2,2,2)
imshow(denoise_median5_5);
mt(2) = title('Median (23.7983)', 'fontsize', 20);
subplot(2,2,3)
imshow(denoise_g_33_05);
mt(3) = title('Gaussian (24.2970)', 'fontsize', 20);
subplot(2,2,4)
imshow(denoise_g_33_15);
mt(3) = title('Gaussian (26.5466)', 'fontsize', 20);
