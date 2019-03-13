clc
clear all
close all
Im1 = imread('boat1.pgm');
Im2 = imread('boat2.pgm');
[imy,imx] = size(Im1);
[matches, scores, fa, fb] = keypoint_matching(Im2, Im1);

N = 10;
P = 10;
[M, positions, inliners] = RANSAC(fa,fb,matches,N,P);

% Calculating new positions for each points and setting the values in I for
% that pixel
I = zeros(imy*3, imx*3);
for x = 1:imx*3
    for y = 1:imy*3
        A = locations_to_A_matrix([x], [y]);
        newpositions = A * M;
        newx = round(newpositions(1) - imx);
        newy = round(newpositions(2) - imy);
        if all(newy > 0 & newy <= imy & newx > 0 & newx <= imx)
            I(y, x) = Im1(newy, newx);
        else
            I(y, x) = 0;
        end
    end
end

% Remove zero rows
I( all(~I,2), : ) = [];
% Remove zero columns
I( :, all(~I,1) ) = [];
%I = imgaussfilt(I,0.5);
imshow(mat2gray(I));
