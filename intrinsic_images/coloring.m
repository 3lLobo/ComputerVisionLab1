clear

b_albedo = im2double(imread('ball_albedo.png')); % read albedo of the ball image
b_shading = im2double(imread('ball_shading.png')); % read shading of the ball image
orig_ball = im2double(imread('ball.png')); % read original ball image

b_albedo_green = im2double((b_albedo > 0));
b_albedo_green(:,:,1) = 0;
b_albedo_green(:,:,3) = 0;

ball_reconstruct_orig = b_albedo.*b_shading; %reconstruct ball image

ball_reconstruct_green = b_albedo_green.*b_shading; %reconstruct ball image

% plotting results
figure;
subplot(2,4,1)
imshow(b_albedo);
mt(1) = title('Albedo', 'FontSize', 24);
subplot(2,4,2)
imshow(b_shading);
mt(2) = title('Shading', 'FontSize', 24);
subplot(2,4,6)
imshow(b_shading);
subplot(2,4,3)
imshow(ball_reconstruct_orig);
mt(3) = title('Reconstruction', 'FontSize', 24);
subplot(2,4,4)
imshow(orig_ball);
mt(4) = title('Original', 'FontSize', 24);
subplot(2,4,8)
imshow(orig_ball);
subplot(2,4,5)
imshow(b_albedo_green);
subplot(2,4,7)
imshow(ball_reconstruct_green);


