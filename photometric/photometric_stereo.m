
close all
clear all
clc
 
disp('Part 1: Photometric Stereo')

% obtain many images in a fixed view under different illumination
disp('Loading images...')
image_dir = './photometrics_images/MonkeyColor/';   % TODO: get the path of the script
%image_ext = '*.png';
color_mode = false

max_channel = 1;
if color_mode == true
    max_channel = 3;
end

for channel = 1:max_channel
    [image_stack, scriptV] = load_syn_images(image_dir,channel);
    if channel > 1
        image_stack = cat(3,image_stack2,image_stack);
        scriptV = cat(1,scriptV2, scriptV);
    end
    image_stack2 = image_stack;
    scriptV2 = scriptV;
end

[h, w, n] = size(image_stack);    
fprintf('Finish loading %d images.\n\n', n);


% compute the surface gradient from the stack of imgs and light source mat
disp('Computing surface albedo and normal map...')
if color_mode == true
    im_count = n/max_channel;
    for cnl = 1:max_channel
        im_range = (im_count*(cnl-1)):(im_count*cnl);
        [albedo(:,:,cnl), cnl_normals(:,:,:,cnl)] = estimate_alb_nrm(image_stack(:,:,im_range), scriptV(im_range,:));
    end
    normals = cnl_normals(:,:,:,1);
    for n = 2:max_channel
        normals = normals + cnl_normals(:,:,:,n);
    end
    normals = normals./4;
else
    [albedo, normals] = estimate_alb_nrm(image_stack, scriptV);
end


%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));

%% compute the surface height
height_map = construct_surface( p, q );

%% Display
show_results(albedo, normals, SE);
show_model(albedo, height_map);


%% Face
[image_stack, scriptV] = load_face_images('./yaleB02/');
[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);
disp('Computing surface albedo and normal map...')
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV);

%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));

%% compute the surface height
height_map = construct_surface( p, q );

show_results(albedo, normals, SE);
show_model(albedo, height_map);

