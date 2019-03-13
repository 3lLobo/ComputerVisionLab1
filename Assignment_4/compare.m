% compare imarp to our results

mt = affine2d([M, T; 0, 0, 1]');

imwarp_im = imwarp(Im2, mt);

imshow(imwarp_im)