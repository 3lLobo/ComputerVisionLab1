clc
clear all
close all
Im1 = imread('boat1.pgm');
Im2 = imread('boat2.pgm');
[imy,imx] = size(Im2);
[matches, scores, fa, fb] = keypoint_matching(Im1,Im2);

N = 700;
K = 700;
[M, T, inliners] = RANSAC(fa,fb,matches,N,K);

%create template double the size of the org image

temp = zeros(imy*2,imx*2);

for y = 1:imy
    for x = 1:imx
        %translate and rotate matriy points
        newvec = M* [x;y] + T;
        newx = newvec(1) + imx;
        newy = newvec(2) + imy;
        %convert to inegers
        newx = int16(newx);
        newy = int16(newy);
        %apply pixels to new coordinates
        temp(newy, newx) = Im2(y,x);
    end
end


%delete zero rows and vetors
temp( ~any(temp,2), : ) = [];  %rows
temp( :, ~any(temp,1) ) = [];  %columns

t4im = uint8(temp);
imshow(t4im)
