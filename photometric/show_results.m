function show_results( albedo, normals, SE )
%SHOW_RESULTS display albedo, normal and computational errors

[h, w, ~] = size(normals);

% plot the results
figure
subplot(2, 3, 1);
[X, Y] = meshgrid(1:w, 1:h);
surf(X, Y, SE, gradient(SE));
title('Integrability check: (dp / dy - dq / dx) ^2 ');

subplot(2, 3, 2);
imshow(albedo);
title('Albedo');

subplot(2, 3, 3);
minN = min(min(normals, [], 1), [], 2);
maxN = max(max(normals, [], 1), [], 2);
normal_img = (normals - minN) ./ (maxN - minN);
% NOTE: all 3 operations(-, /, -) are done in in broadcasting manner
% before MATLAB2016B, must use BSXFUN(@minus, normals, minN), ...
imshow(normal_img);
title('Normal map');

subplot(2, 3, 4);
imshow(normal_img(:, :, 1));
title('Normal X-component');

subplot(2, 3, 5);
imshow(normal_img(:, :, 2));
title('Normal Y-component');

subplot(2, 3, 6);
imshow(normal_img(:, :, 3));
title('Normal Z-component');


end

