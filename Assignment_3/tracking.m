function tracking(folder)
    mainfolder = strcat(pwd, '\');
    if strcmp(folder, 'pingpong')
        subfolder = 'pingpong\';
        filetypes = '*.jpeg';
        filename = 'pingpong.gif';
    else
        subfolder = 'person_toy\';
        filetypes = '*.jpg';
        filename = 'person_toy.gif';
    end
        
    % Load all files
    matfiles = dir(fullfile(mainfolder, subfolder, filetypes));
    nfiles = length(matfiles);
    
    % Set values
    harris_treshold = 0.005;
    window_size = 20;
    vector_multiplier = 8;

    % Reading out first file
    I_pp = imread(fullfile(mainfolder, subfolder, matfiles(1).name));
    I_pp_gray = rgb2gray(I_pp);
    I_pp_gd = im2double(I_pp_gray);
    [m,n] = size(I_pp_gray);
    % Calculate the positions in the first frame so:
    % Perform harris to get the corners c
    [H, r, c] = harris_corner_detection(I_pp_gd, harris_treshold, false);
    % So c are the features we want to track

    f = figure('visible','off');
    for filenr = 1 : nfiles - 1
        % Getting the movement directions using lucas kanade:
        [dx, dy] = lucas_kanade_tracking_version(fullfile(mainfolder, subfolder, matfiles(filenr).name), fullfile(mainfolder, subfolder, matfiles(filenr+1).name), c, r, window_size);
        
        % Saving to gif
        imshow(fullfile(mainfolder, subfolder, matfiles(filenr).name));
        hold on;
        plot(c, r, 'r*', 'LineWidth', 2, 'MarkerSize', 2);
        %plot(c + dx, r + dy, 'g*', 'LineWidth', 2, 'MarkerSize', 2);
        quiver(c, r, dx, dy, 'color',[1 0 1]);
        frame = getframe(f); 
        im = frame2im(frame); 
        name = (['Feature tracking with window size ', num2str(window_size)]);
        title(name, 'fontsize', 15);
        
        % GIF saving technique inspired by: 
        % https://nl.mathworks.com/matlabcentral/answers/94495-how-can-i-create-animated-gif-images-in-matlab
        [imind,cm] = rgb2ind(im,256);
        if filenr == 1 
            imwrite(imind,cm,strcat(mainfolder,'results/', filename),'gif', 'Loopcount',inf,'DelayTime',0.1); 
        else 
            imwrite(imind,cm,strcat(mainfolder,'results/', filename),'gif','WriteMode','append','DelayTime',0.1); 
        end 
        
        c = c + (dx * vector_multiplier);
        r = r + (dy * vector_multiplier);        
    end
    
end

function [V_x, V_y] = lucas_kanade_tracking_version(path1, path2, c, r, window_size)
    % Modified version to work with features we want to track.

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
   c = floor(c);
   r = floor(r);
    %num_windows_y = floor(size(image1,2)/window_size);

    % Save results in V_x and V_y
    V_x = zeros(length(c), 1);
    V_y = zeros(length(c), 1);

    % Get shapes image
    [m,n] = size(image1);

    for i = 1:length(c)

        % Make sure the function doesnt go out of bound
        
        x_1 = r(i) - (window_size / 2);
        if x_1 < 1
            x_1 = 1;
        elseif x_1 >= m - window_size
            x_1 = m - window_size - 1;
        end

        y_1 = c(i) - (window_size / 2);
        if y_1 < 1
            y_1 = 1;
        elseif y_1 >= n - window_size
            y_1 = n - window_size - 1;
        end
        x_1 = round(x_1);
        y_1 = round(y_1);
        x_2 = round(x_1 + window_size - 1);
        y_2 = round(y_1 + window_size - 1);      
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

        V_x(i) = v(1);
        V_y(i) = v(2);
    end
    % replace NaN values with zeros
    V_x(isnan(V_x))=0;
    V_y(isnan(V_y))=0; 
    

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

