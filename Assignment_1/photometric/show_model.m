function show_model(albedo, height_map)
% SHOW_MODEL: display the model with texture
%   albedo: image used as texture for the model
%   height_map: height in z direction, describing the model geometry
% Spring 2014 CS 543 Assignment 1
% Arun Mallya and Svetlana Lazebnik


% some cosmetic transformations to make 3D model look better
[hgt, wid] = size(height_map);
[X,Y] = meshgrid(1:wid, 1:hgt);
H = rot90(fliplr(height_map), 2);
A = rot90(fliplr(albedo), 2);

figure;
mesh(H, X, Y, A);
axis equal;
xlabel('Z')
ylabel('X')
zlabel('Y')
title('Height Map')
view(-60,20)
colormap(gray)
set(gca, 'XDir', 'reverse')
set(gca, 'XTick', []);
set(gca, 'YTick', []);
set(gca, 'ZTick', []);
end

