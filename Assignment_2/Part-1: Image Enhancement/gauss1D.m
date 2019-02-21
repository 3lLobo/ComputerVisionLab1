function G = gauss1D( sigma , kernel_size )

    if mod(kernel_size, 2) == 0
        error('kernel_size must be odd, otherwise the filter will not have a center to convolve on')
    end
    
    % create x
    fks = floor(kernel_size/2);
    x = -fks:1:fks;
    % compute gaussian filter for x
    G = normpdf(x, 0, sigma);
    % normalize filter
    G = G / sum(G(:));       
end
