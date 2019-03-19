function descriptors = ext_from_single_obs(obervation, type)

    im_rgb = reshape(obervation, 96, 96, 3);
    im_gs = rgb2gray(im_rgb);
    I_gs = single(rgb2gray(im_rgb));
    [f_gs, d_gs] = vl_sift(I_gs);

    if type=="rgb"
        I_rgb = im2single(im_rgb);
        
        descriptors = [];
        for channel_i = 1:size(I_rgb, 3)
            channel = I_rgb(:, :, channel_i);
            [~, d_channel] =  vl_sift(channel, 'Frames', f_gs);
            descriptors = [descriptors ; d_channel];
        end
        descriptors = transpose(descriptors);  

    elseif type=="opponent"
        im_opp = make_opponent(im_rgb);
        I_opp = im2single(im_opp);
        
        descriptors = [];
        for channel_i = 1:size(I_opp, 3)
            channel = I_opp(:, :, channel_i);
            [~, d_channel] =  vl_sift(channel, 'Frames', f_gs);
            descriptors = [descriptors ; d_channel];
        end
        descriptors = transpose(descriptors);
    
    elseif type=="gray"
        descriptors = transpose(d_gs);

    else
        disp("Wrong color type as input?")
        return
    
    end

end
