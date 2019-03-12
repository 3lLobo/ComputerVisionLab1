%##### Run Demo with: 
% lucas_kanade_demo("pingpong/0004.jpeg", "pingpong/0005.jpeg", 12); 
% lucas_kanade_demo("sphere1.ppm", "sphere2.ppm", 15) 
% lucas_kanade_demo("synth1.pgm", "synth2.pgm", 15)
function lucas_kanade_demo(path1, path2, window_size)
    [V_x, V_y] = lucas_kanade(path1, path2, window_size);
    plot_only_quiver(V_x, V_y, window_size);
    plot_on_image(path1, V_x, V_y, window_size); 
end

function plot_only_quiver(V_x, V_y, win_size)
    i = ceil(win_size/2);
    num_win_x = size(V_x, 2);
    num_win_y = size(V_x, 1);
    [x,y] = meshgrid(i:win_size:num_win_x*win_size,num_win_y*win_size:-win_size:i);
    quiver(x,y,V_x,-V_y, 'color',[1 0 1]);  
end

function plot_on_image(path, V_x, V_y, win_size)    
    i = ceil(win_size/2);
    num_win_x = size(V_x, 2);
    num_win_y = size(V_x, 1);
    [x,y] = meshgrid(i:win_size:num_win_x*win_size,i:win_size:num_win_y*win_size);
    
    figure;
    imshow(imread(path), []);
    hold on;
    quiver(x,y,V_x,V_y, 'color',[1 0 1]);  
    %saveas(gcf, "fig2.png");
end

