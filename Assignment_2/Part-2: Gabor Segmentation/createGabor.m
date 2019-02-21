function [ myGabor ] = createGabor( sigma, theta, lambda, psi, gamma )
%CREATEGABOR Creates a complex valued Gabor filter.
%   myGabor = createGabor( sigma, theta, lambda, psi, gamma ) generates
%   Gabor kernels.  
%   - ARGUMENTS
%     sigma      Standard deviation of Gaussian envelope.
%     theta      Orientation of the Gaussian envelope. Takes arguments in
%                the range [0, pi/2).
%     lambda     The wavelength for the carriers. The central frequency 
%                (w_c) of the carrier signals.
%     psi        Phase offset for the carrier signal, sin(w_c . t + psi).
%     gamma      Controls the aspect ratio of the Gaussian envelope
%   
%   - OUTPUT
%     myGabor    A matrix of size [h,w,2], holding the real and imaginary 
%                parts of the Gabor in myGabor(:,:,1) and myGabor(:,:,2),
%                respectively.
                
% Set the aspect ratio.
sigma_x = sigma;
sigma_y = sigma/gamma;

% Generate a grid
nstds = 3;
xmax = max(abs(nstds*sigma_x*cos(theta)),abs(nstds*sigma_y*sin(theta)));
xmax = ceil(max(1,xmax));
ymax = max(abs(nstds*sigma_x*sin(theta)),abs(nstds*sigma_y*cos(theta)));
ymax = ceil(max(1,ymax));

% Make sure that we get square filters. 
xmax = max(xmax,ymax);
ymax = max(xmax,ymax);
xmin = -xmax; ymin = -ymax;

% Generate a coordinate system in the range [xmin,xmax] and [ymin, ymax]. 
[x,y] = meshgrid(xmin:xmax,ymin:ymax);

% Convert to a 2-by-N matrix where N is the number of pixels in the kernel.
XY = [reshape(x, 1, []);reshape(y, 1, [])];

% Compute the rotation of pixels by theta.
% \\ Hint: Use the rotation matrix to compute the rotated pixel
%          coordinates: rot(theta) * XY.
rotMat = generateRotationMatrix(theta);
rot_XY = rotMat*XY;
rot_x = rot_XY(1,:);
rot_y = rot_XY(2,:);


% Create the Gaussian envelope.
% \\ IMPLEMENT the helper function createGauss.
gaussianEnv = createGauss(rot_x, rot_y, gamma, sigma);

% Create the orthogonal carrier signals.
% \\ IMPLEMENT the helper functions createCos and createSin.
cosCarrier = createCos(rot_x, lambda, psi);
sinCarrier = createSin(rot_x, lambda, psi);

% Modulate (multiply) Gaussian envelope with the carriers to compute 
% the real and imaginary components of the omplex Gabor filter. 
myGabor_real =      % \\TODO: modulate gaussianEnv with cosCarrier
myGabor_imaginary = % \\TODO: modulate gaussianEnv with sinCarrier

% Pack myGabor_real and myGabor_imaginary into myGabor.
myGabor(:,:,1) = myGabor_real;
myGabor(:,:,2) = myGabor_imaginary;

% figure;
% subplot(121), imshow(myGabor_real,[]);
% subplot(122), imshow(myGabor_imaginary, []);
end


% Helper Functions 
% ----------------------------------------------------------
function rotMat = generateRotationMatrix(theta)
% ----------------------------------------------------------
% Returns the rotation matrix. 
% \\ Hint: https://en.wikipedia.org/wiki/Rotation_matrix \\
rotMat = % \\TODO: code the rotation matrix given theta.
end

% ----------------------------------------------------------
function cosCarrier = createCos(rot_x, lambda, psi)
% ----------------------------------------------------------
% Returns the 2D cosine carrier. 
cosCarrier = % \\TODO: Implement the cosine given rot_x, lambda and psi.

% Reshape the vector representation to matrix.
cosCarrier = reshape(cosCarrier, sqrt(length(cosCarrier)), []);
end

% ----------------------------------------------------------
function sinCarrier = createSin(rot_x, lambda, psi)
% ----------------------------------------------------------
% Returns the 2D sine carrier. 
sinCarrier = % \\TODO: Implement the sine given rot_x, lambda and psi.

% Reshape the vector representation to matrix.
sinCarrier = reshape(sinCarrier, sqrt(length(sinCarrier)), []);
end

% ----------------------------------------------------------
function gaussEnv = createGauss(rot_x, rot_y, gamma, sigma)
% ----------------------------------------------------------
% Returns the 2D Gaussian Envelope. 
gaussEnv = % \\TODO: Implement the Gaussian envelope.

% Reshape the vector representation to matrix.
gaussEnv = reshape(gaussEnv, sqrt(length(gaussEnv)), []);
end