function [oppo] = make_opponent(image)
%% Create opponent color image for given RGB image.
width = size(image,1);

r = image(:,:,1);
g = image(:,:,2);
b = image(:,:,3);

oppo = zeros(width,width,3);
oppo(:,:,1) = (r-g)/sqrt(2);
oppo(:,:,2) = (r+g-2*b)/sqrt(6);
oppo(:,:,3) = (r+g+b)/sqrt(3);

oppo = uint8(oppo);

end