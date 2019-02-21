function [output_image] = rgb2opponent(input_image)
% converts an RGB image into opponent color space
[R, G, B] = getColorChannels(input_image);
O1 = double(R - G) ./ sqrt(2);
O2 = double((R + G) - (B.*2)) ./ sqrt(6);
O3 = double(R + G + B) ./ sqrt(3);

output_image(:, :, 1) = O1;
output_image(:, :, 2) = O2;
output_image(:, :, 3) = O3;
end