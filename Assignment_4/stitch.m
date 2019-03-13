function [stitched_image] = stitch_2(im_left, im_right, N, K)

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


% Remove zero rows
stitched_image( all(~stitched_image,[2, 3]), : , :) = [];
% Remove zero columns
stitched_image( :, all(~stitched_image,[1,3]), :) = [];

stitched_image = uint8(stitched_image);

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
    [imy, imx] = size(im_gray);
    im_trans = zeros(500, 500, 3);
    for x = 1:500
        for y = 1:500
            coord = M * [x; y] + T;
            coord = round(coord);
            newx = round(coord(1));
            newy = round(coord(2));
            
            if all(newy > 0 & newy <= imy & newx > 0 & newx <= imx)
                color_oc = im_color(newy, newx, 1);
                im_trans(y, x, 1) = im_color(newy, newx, 1);
                im_trans(y, x, 2) = im_color(newy, newx, 2); 
                im_trans(y, x, 3) = im_color(newy, newx, 3); 
            else
                im_trans(y, x, :) = 0; 
            end
        end
    end
    im_trans = uint8(im_trans);
    figure;
    imshow(im_trans);
end
