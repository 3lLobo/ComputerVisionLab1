clc
clear all
close all

Im1 = imread('boat1.pgm');
Im2 = imread('boat2.pgm');
[imy,imx] = size(Im2);
[matches, scores, fa, fb] = keypoint_matching(Im1,Im2);

N = 10;
K = 10;
[M, T, inliners] = RANSAC(fa,fb,matches,N,K);

xgrid = meshgrid(1:imx, 1:imy);
ygrid = meshgrid(1:imy, 1:imx)';

rotx = M(1,1).*xgrid + M(1,2).*ygrid + T(1);
roty = M(2,1).*xgrid + M(2,2).*ygrid + T(2);
rotx = int32(rotx);
roty = int32(roty);

%negative offset
offx = abs(min(min(rotx))) + 1;
offy = abs(min(min(roty))) + 1;
shiftedx = rotx + offx;
shiftedy = roty + offy;

newgrid = zeros(int32(max(max(shiftedy))),int32(max(max(shiftedx))));
for x = 1:imx
    for y = 1:imy
        newgrid(shiftedy(y,x),shiftedx(y,x)) = Im2(y,x);
    end
    
end


