function [stitched_image] = stitch(im_left, im_right, N, K)

im_left_gray = rgb2gray(im_left);
im_right_gray = rgb2gray(im_right);

[matches, ~, fa, fb] = keypoint_matching(im_right_gray, im_left_gray);
[M, T, ~] = RANSAC(fa, fb, matches, N, K);
size(M)
size(T)
for x = 1:size(im_right_gray, 2)
    for y = 1:size(im_right_gray, 1)
        coord = M * [x; y] + T;
        coord = round(coord);
        color_oc = im_right(y, x, :);
        new_im(coord(2), coord(1), :) = color_oc; 
    end
end

size(new_im)
imshow(new_im)

end