clc
clear all
close all
Im1 = imread('boat2.pgm');
Im2 = imread('boat1.pgm');
[imy,imx] = size(Im1);
[matches, scores, fa, fb] = keypoint_matching(Im1,Im2);

N = 10;
P = 10;
[M, positions, inliners] = RANSAC_lucas(fa,fb,matches,N,P);

% Calculating new positions for each points and setting the values in I for
% that pixel
I = zeros(imy*3, imx*3);
for x = 1:imx
    for y = 1:imy
        A = locations_to_A_matrix([x], [y]);
        newpositions = A * M;
        newx = round(newpositions(1) + (imx));
        newy = round(newpositions(2) + (imy));
        I(newy, newx) = Im1(y,x);
    end
end

% Remove zero rows
I( all(~I,2), : ) = [];
% Remove zero columns
I( :, all(~I,1) ) = [];
imshow(mat2gray(I));
