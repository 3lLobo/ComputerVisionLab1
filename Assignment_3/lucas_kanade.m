function [V_x, V_y] = lucas_kanade(path1, path2, window_size)

% Read input images 
image1 = im2double(imread(path1));
image2 = im2double(imread(path2));
% Transform to grayscale 
image1 = grayscale_image(image1);
image2 = grayscale_image(image2);

% compute all first derivatives for x and y
[I_x, I_y] = prewitt_image_derivate(image1);
%imshow(I_x)
%imshow(I_y)

% compute all temporal derivates
I_t = image2-image1;

% (1) Divide input images on non-overlapping regions, 
% each region being window_size × window_size.
num_windows_x = floor(size(image1,1)/window_size);
num_windows_y = floor(size(image1,2)/window_size);

% Save results in V_x and V_y
V_x = zeros(num_windows_x, num_windows_y);
V_y = zeros(num_windows_x, num_windows_y);

for x_1 = 1:window_size:window_size*num_windows_x
    for y_1 = 1:window_size:window_size*num_windows_y
        x_2 = x_1+window_size-1;
        y_2 = y_1+window_size-1;
        
        % (2) For each region compute A, A.T and b. 
        % Then, estimate optical flow as given in Equation 20.
        
        % compute A
        i_x = I_x(x_1:x_2, y_1:y_2);
        i_y = I_y(x_1:x_2, y_1:y_2);
        A = [i_x(:), i_y(:)];
        
        % compute b
        b = I_t(x_1:x_2, y_1:y_2);
        b = b(:);
        
        % estimate optical flow
        v = inv(A'*A)*A'*b;
        
        id_x = floor(x_2/window_size);
        id_y = floor(y_2/window_size);
        
        V_x(id_x, id_y) = v(1);
        V_y(id_x, id_y) = v(2);
    end
    % replace NaN values with zeros
    V_x(isnan(V_x))=0;
    V_y(isnan(V_y))=0; 
end
end

function [I_x, I_y] = prewitt_image_derivate(I)
    % We use Prewitt filters for calculating 
    % the derivative of an image
    filter_x_prewitt = [1 0 -1; 1 0 -1; 1 0 -1];
    filter_y_prewitt = [1 1 1; 0 0 0; -1 -1 -1];
        
    % apply filters 
    I_x = imfilter(I, filter_x_prewitt);
    I_y = imfilter(I, filter_y_prewitt);
    
    % Normalize output; 1/6 is the normalization factor for the 
    % prewitt filters
    % I_x = I_x/6
    % I_y = I_y/6
end

function [I_bw] = grayscale_image(I)
    if size(I,3) == 3
        I_bw = rgb2gray(I);
    else
        I_bw = I;
    end
end



