function [image] = resize_image(im_row)

vec_size = size(im_row,2);
sq_size = vec_size/3;
width = sqrt(sq_size);
r = reshape(im_row(1,1:sq_size),[width,width]);
g = reshape(im_row(1,1+sq_size:2*sq_size),[width,width]);
b = reshape(im_row(1,1+2*sq_size:3*sq_size),[width,width]);
image = zeros(width, width, 3);
image(:,:,1) = r;
image(:,:,2) = g;
image(:,:,3) = b;
image = uint8(image);

end