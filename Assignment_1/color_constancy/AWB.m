grey_world("ocean.jpg", "ocean_out.jpg")

function grey_world(input_file_name, output_file_name)
P = imread(input_file_name);
P_lin = rgb2lin(P);
illuminant = gw_illuminant(P_lin);
P_lin = chromadapt(P_lin,illuminant,'ColorSpace','linear-rgb', 'Method', 'vonkries');
P_out = lin2rgb(P_lin);
safe_correction_figure(P, P_out, output_file_name);
end

function [illuminant] = gw_illuminant (image)
s = size(image);
pixels = reshape(image, [(s(1)*s(2)) s(3)]);
illuminant = mean(pixels, 1)
end

function safe_correction_figure (image_orig, image_corrected, output_file_name)
figure(1),
set(gcf, 'Position', get(0,'Screensize')); 
subplot(1,2,1), imshow(image_orig); title('Original Image');
subplot(1,2,2), imshow(image_corrected); title('Gray World Correction');
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [2 1 5 3]);
saveas(gcf,output_file_name)
end


