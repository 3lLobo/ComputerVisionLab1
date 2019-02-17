function [ albedo, normal ] = estimate_alb_nrm( image_stack, scriptV, shadow_trick)
%COMPUTE_SURFACE_GRADIENT compute the gradient of the surface
%   image_stack : the images of the desired surface stacked up on the 3rd
%   dimension
%   scriptV : matrix V (in the algorithm) of source and camera information
%   shadow_trick: (true/false) whether or not to use shadow trick in solving
%   	linear equations
%   albedo : the surface albedo
%   normal : the surface normal


[h, w, ~] = size(image_stack);
if nargin == 2
    shadow_trick = true;
end

% create arrays for 
%   albedo (1 channel)
%   normal (3 channels)
albedo = zeros(h, w, 1);
normal = zeros(h, w, 3);

% =========================================================================
% YOUR CODE GOES HERE
% for each point in the image array
%   stack image values into a vector i
%   construct the diagonal matrix scriptI
%   solve scriptI * scriptV * g = scriptI * i to obtain g for this point
%   albedo at this point is |g|
%   normal at this point is g / |g|

for x = 1:h
    for y = 1:w
        ii = squeeze(image_stack(x,y,:));
        if norm(ii)==0
            g(x,y,:)=[0 0 0];
        else
            if shadow_trick == false
                i_shadow = diag(ii);
                scriptV = i_shadow*scriptV;
                ii = i_shadow*ii;
            end

            g(x,y,:) = linsolve((scriptV), (ii));
        end
        albedo(x,y) = norm(squeeze(g(x,y,:)));
        normal(x,y,:) = g(x,y,:)/albedo(x,y);
    end
end





% =========================================================================

end

