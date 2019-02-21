function [output_image] = rgb2grays(input_image)
% converts an RGB into grayscale by using 4 different methods
[R, G, B] = getColorChannels(input_image);


% ligtness method
Li = max(max(R, G), B) + min(min(R, G), B) ./2;

% average method
A = (R + G + B) / 2;

% luminosity method
Lu = double(double(0.21 * R) + double(0.72 * G) + double(0.07) * B);

% built-in MATLAB function 
built_in = rgb2gray(input_image);

output_image(:, :, 1) = Li;
output_image(:, :, 2) = A;
output_image(:, :, 3) = Lu;
output_image(:, :, 4) = built_in;

end

