function imOut = compute_LoG(image, LOG_type)
I = imread(image);

switch LOG_type
    case 1
        %method 1
        g = gauss2D( 0.5 , 5);
        I = imfilter(I,g,'replicate');
        h = fspecial('laplacian');
        edge = imfilter(I,h,'replicate'); 
        
    case 2
        %method 2
        h = fspecial('log',5,0.5);
        edge = imfilter(I,h,'replicate'); 
        
    case 3
        %method 3
        h1 = fspecial('gaussian',5,0.8);
        h2 = fspecial('gaussian',5,0.5);
        h = h1-h2;
        edge = imfilter(I,h,'replicate'); 
    
end

imOut = mat2gray(edge);
%imOut = edge;
end