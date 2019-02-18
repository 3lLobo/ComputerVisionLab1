b_albedo = im2double(imread('ball_albedo.png')); % read albedo of the ball image
b_shading = im2double(imread('ball_shading.png')); % read shading of the ball image
orig_ball = im2double(imread('ball.png')); % read original ball image

ball_reconstruct = b_albedo.*b_shading; %reconstruct ball image

test = imread('ball_albedo.png');
size(test)
test(133, 240, :)

% plotting results
figure;
subplot(1,4,1)
imshow(b_albedo);
mt(1) = title('Albedo');
subplot(1,4,2)
imshow(b_shading);
mt(2) = title('Shading');
subplot(1,4,3)
imshow(ball_reconstruct);
mt(3) = title('Reconstruction');
subplot(1,4,4)
imshow(orig_ball);
mt(4) = title('Original');
