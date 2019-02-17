function [output_image] = rgb2normedrgb(input_image)
% converts an RGB image into normalized rgb
[R, G, B] = getColorChannels(input_image);
RGB = double(R+G+B);

output_image(:, :, 1) = double(R) ./ RGB;
output_image(:, :, 2) = double(G) ./ RGB;
output_image(:, :, 3) = double(B) ./ RGB;
end

