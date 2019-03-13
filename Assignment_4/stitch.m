function [stitched_image] = stitch(im_left, im_right, N, K)

% grey versions of the images
im_left_gray = rgb2gray(im_left);
im_right_gray = rgb2gray(im_right);

% perform keypoint matching
[matches, ~, fa, fb] = keypoint_matching(im_right_gray, im_left_gray);

% perform RANSAC on keypoints + get parameters
[tm, ~, ~] = RANSAC_lucas(fa, fb, matches, N, K);
M = [tm(1), tm(2); tm(3), tm(4)];
T = [tm(5); tm(6)];

% transform image with RANSAC parameters
im_right_trans = image_transform_ransac(im_right, im_right_gray, M, T);

% correct transfomed image to be stitched to have the same x-size through
% padding zeros to its end
[stitched_image, ~] = equal_x_padding(im_right_trans, im_left);

% Add orginal left image and transformed right image
[dimx_l,dimy_l,~] = size(im_left);
for i = 1:1:dimx_l
    for j = 1:1:dimy_l
        stitched_image(i,j,:) = im_left(i,j,:);
    end
end

end

function [im_right_eq, im_left_eq] = equal_x_padding(im_right, im_left)
    % Bring images to have equal size by adding zero padding to bottom.
    % (Both images, because we want to cover the case that the right one is
    % longer.)
    im_right_eq = image_padding(im_right,size(im_left,1)-size(im_right,1));
    im_left_eq  = image_padding(im_left,size(im_right,1)-size(im_left,1)); 
end

function [image] = image_padding(image,x)
    % Add zero padding to image:
    % x rows of zeros to the bottom 
    if x>0
        pad = zeros(x, size(image,2),size(image,3));
        image = cat(1,image, pad);
    end
end

function [im_trans] = image_transform_ransac(im_color, im_gray, M, T)
    % Transform image with RANSAC parameters
    for x = 1:size(im_gray, 2)
        for y = 1:size(im_gray, 1)
            coord = M * [x; y] + T;
            coord = round(coord);
            color_oc = im_color(y, x, :);
            im_trans(coord(2), coord(1), :) = color_oc; 
        end
    end
end
