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

% correct images to be stitched to have the same size through padding  
[im_right_eq, im_left_eq] = equal_size_padding(im_right_trans, im_left);


% Stitch transformed right image onto left image
[dimx,dimy,dimz] = size(im_left_eq);

for i = 1:1:dimx
    for j = 1:1:dimy
        if im_right_eq(i,j)==0
            stitched_image(i,j,:) = im_left_eq(i,j,:);
        else
            stitched_image(i,j,:) = im_right_eq(i,j,:);
        end
    end
end

% TODO: Add some smoothing here?

end

function [im_right_eq, im_left_eq] = equal_size_padding(im_right, im_left)
    % Bring images to have equal size by adding zero padding to bottom and
    % right.
    r_bot = size(im_left,1)-size(im_right,1);
    r_right = size(im_left,2)-size(im_right,2);
    im_right_eq = image_padding(im_right,r_bot,r_right);

    l_bot  = size(im_right,1)-size(im_left,1);
    l_right = size(im_right,2)-size(im_left,2);
    im_left_eq = image_padding(im_left,l_bot,l_right); 
end

function [im_pad] = image_padding(image,x,y)
    % Add zero padding to image:
    % x rows and y columns, to the bottom and the right respectively
    if x>0
        pad = zeros(x, size(image,2),size(image,3));
        im_pad = cat(1,image, pad);
    end
    if y>0
        pad = zeros(size(image,1),y,size(image,3));
        im_pad = cat(2,image, pad);
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

