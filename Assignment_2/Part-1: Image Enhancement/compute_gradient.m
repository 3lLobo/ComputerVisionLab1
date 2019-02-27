function [Gx, Gy, im_magnitude,im_direction] = compute_gradient(image)
    % grayimage = rgb2gray(image);
    % grayimage = double(grayimage);
    grayimage = double(image);
    kernelx = double([1 0 -1;2 0 -2;1 0 -1]);
    kernely = kernelx.';
    [m,n] = size(grayimage);
    Gx = zeros(m-2, n-2);
    Gy = zeros(m-2, n-2);
    for i = 1:m-2
        for j = 1:n-2
            Gx(i,j) = sum(kernelx.*grayimage(i:i+2,j:j+2), 'all');
            Gy(i,j) = sum(kernely.*grayimage(i:i+2,j:j+2), 'all');
        end;
    end;
    im_magnitude = sqrt(Gx.^2 + Gy.^2);
    im_direction = atan(Gy./Gx);
    close all;
    figure;
    imshow(image);
    figure;
    suptitle('Sobel kernels');
    set(gcf, 'Position',  [100, 100, 1000, 800])
    subplot(2,2,1), subimage(mat2gray(Gx));
    set(gca,'xtick',[],'ytick',[]);
    title('Gx');
    
    subplot(2,2,2), subimage(mat2gray(Gy));
    set(gca,'xtick',[],'ytick',[]);
    title('Gy');
    
    subplot(2,2,3), subimage(mat2gray(im_magnitude));
    set(gca,'xtick',[],'ytick',[]);
    title('Magnitude');
    
    subplot(2,2,4), subimage(mat2gray(im_direction));
    set(gca,'xtick',[],'ytick',[]);
    title('Direction');
end
