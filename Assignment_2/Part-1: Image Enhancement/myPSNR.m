function [ PSNR ] = myPSNR( orig_image, approx_image )

[N, M] = size(orig_image);

img_diff = int32(orig_image) - int32(approx_image);
img_diff_sq = img_diff.^2;
MSE = (1/(N*M))*sum(img_diff_sq, 'all');

RMSE = sqrt(MSE);
I_max = max(orig_image,[],'all');

PSNR = 20 * log10(double(I_max)/RMSE);
    
end