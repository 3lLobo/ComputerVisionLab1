% test your code by using this simple script

clear
clc
close all

I = imread('peppers.png');


J = ConvertColorSpace(I,'opponent');
suptitle('Opponent Color Space');

% close all
J = ConvertColorSpace(I,'rgb');
suptitle('Normalised RGB Color Space');

% close all
J = ConvertColorSpace(I,'hsv');
suptitle('HSV Color Space');

% close all
J = ConvertColorSpace(I,'ycbcr');
suptitle('YCbCr Color Space');

% close all
J = ConvertColorSpace(I,'gray');
suptitle('Grayscale');