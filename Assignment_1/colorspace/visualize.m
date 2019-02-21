function visualize(input_image)
    figure;
    set(gcf, 'Position',  [100, 100, 1000, 800])
    [X, Y, Z] = size(input_image);
    if (Z == 3)
        subplot(2,2,1), subimage(input_image);
        title('Full Image');
        set(gca,'xtick',[],'ytick',[]);

        [C1, C2, C3] = getColorChannels(input_image);
        subplot(2,2,2), subimage(C1);
        set(gca,'xtick',[],'ytick',[]);
        title('Channel 1');

        subplot(2,2,3), subimage(C2);
        set(gca,'xtick',[],'ytick',[]);
        title('Channel 2');

        subplot(2,2,4), subimage(C3);
        set(gca,'xtick',[],'ytick',[]);
        title('Channel 3');
    else
        suptitle('Grayscale');
        subplot(2,2,1), subimage(input_image(:, :, 1));
        title('Lightness');
        set(gca,'xtick',[],'ytick',[]);

        subplot(2,2,2), subimage(input_image(:, :, 2));
        set(gca,'xtick',[],'ytick',[]);
        title('Average');

        subplot(2,2,3), subimage(input_image(:, :, 3));
        set(gca,'xtick',[],'ytick',[]);
        title('Luminosity');

        subplot(2,2,4), subimage(input_image(:, :, 4));
        set(gca,'xtick',[],'ytick',[]);
        title('Built-in grayscale');
end

