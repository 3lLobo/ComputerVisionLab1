function descriptors = ext_from_single_obs(observation, img_type, sift_type)
    
    % get keypoints in overall gray image
    im_rgb = reshape(observation, 96, 96, 3);
    im_gs = rgb2gray(im_rgb);
    I_gs = single(rgb2gray(im_rgb));
    [f_gs, d_gs] = vl_sift(I_gs);

    if img_type=="rgb"
        I_rgb = im2single(im_rgb);
        descriptors = get_descriptors(I_rgb, f_gs, sift_type);  

        
    elseif img_type=="opponent"
        im_opp = make_opponent(im_rgb);
        I_opp = im2single(im_opp);
        descriptors = get_descriptors(I_opp, f_gs, sift_type);
    
        
    elseif img_type=="gray"
        %descriptors = d_gs;
        descriptors = get_descriptors(I_gs, f_gs, sift_type);
        
    else
        disp("Wrong color type as input?")
        return
    end
    
    descriptors = transpose(descriptors);
end

function descriptors = get_descriptors(I, f_gs, sift_type)

    if sift_type == "dense"
        I = vl_imsmooth(I, sqrt((5/3)^2 - .25));
    end
    
    descriptors = [];
    for channel_i = 1:size(I, 3)
        channel = I(:, :, channel_i);
        if sift_type == "dense"
            [~, d_channel] = vl_dsift(channel,'step', 8, 'size', 5);
        else
            [~, d_channel] =  vl_sift(channel, 'Frames', f_gs);
        end
        descriptors = [descriptors ; d_channel];
    end
    
end
