function [gray] = make_gray(image)

width = size(image,1);
gray = zeros(width, width,1);
gray(:,:,1) = .2126 * image(:,:,1) + .7152 * image(:,:,2) + .0722 * image(:,:,3);
gray = uint8(squeeze(gray));

end
