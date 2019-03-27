function [] = save_images(path, images)
%% Write 5x5 grid image.
    img_grid = [];
    for i=1:size(images,2)
        row_grid = [];
        for j=1:size(images{i},1)
            img = reshape(images{i}(j,:), [96,96,3]);
            row_grid = [row_grid, img];
        end
        img_grid = [img_grid; row_grid];
    end
    imwrite(img_grid, path);
end