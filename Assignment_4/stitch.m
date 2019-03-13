function [stitched_image] = stitch(im_left, im_right, N, K, max_scale)

% grey versions of the images
im_left_gray = rgb2gray(im_left);
im_right_gray = rgb2gray(im_right);

% perform keypoint matching
[matches, ~, fa, fb] = keypoint_matching(im_left_gray, im_right_gray);

% perform RANSAC on keypoints + get parameters
[tm, ~, ~] = RANSAC(fa, fb, matches, N, K);
M = [tm(1), tm(2); tm(3), tm(4)];
T = [tm(5); tm(6)];

% transform image with RANSAC parameters
stitched_image = image_transform_ransac(im_right, im_right_gray, M, T, max_scale);

% Add orginal left image and transformed right image
[dimx_l,dimy_l,~] = size(im_left);
for i = 1:1:dimx_l
    for j = 1:1:dimy_l
        stitched_image(i,j,:) = im_left(i,j,:);
    end
end

% Remove zero rows
stitched_image( all(~stitched_image,[2, 3]), : , :) = [];
% Remove zero columns
stitched_image( :, all(~stitched_image,[1,3]), :) = [];

stitched_image = uint8(stitched_image);
end

function [im_trans] = image_transform_ransac(im_color, im_gray, M, T, max_scale)
    % Transform image with RANSAC parameters
    max_x = size(im_color,1)*max_scale;
    max_y = size(im_color,2)*max_scale;
    [imy, imx] = size(im_gray);
    im_trans = zeros(max_x, max_y, 3);
    for x = 1:max_x
        for y = 1:max_y
            coord = M * [x; y] + T;
            coord = round(coord);
            newx = round(coord(1));
            newy = round(coord(2));
            
            if all(newy > 0 & newy <= imy & newx > 0 & newx <= imx)
                im_trans(y, x, 1) = im_color(newy, newx, 1);
                im_trans(y, x, 2) = im_color(newy, newx, 2); 
                im_trans(y, x, 3) = im_color(newy, newx, 3); 
            else
                im_trans(y, x, :) = 0; 
            end
        end
    end
    im_trans = uint8(im_trans);
end
