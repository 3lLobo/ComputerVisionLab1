function G = gauss2D( sigma , kernel_size )
    G_x = gauss1D(sigma, kernel_size);
    % Note: G_x and G_y in the given formel are the same, 
    % only transposed. Therefore we only need to compute one
    % gauss1D here.
    G = (G_x)'*G_x;
end
