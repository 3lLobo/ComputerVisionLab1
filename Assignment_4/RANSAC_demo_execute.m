clc
clear all
close all
Im1 = imread('boat1.pgm');
Im2 = imread('boat2.pgm');
figure;
imshow(Im1);
figure;
imshow(Im2);
RANSAC_demo(Im1, Im2);
RANSAC_demo(Im2, Im1);