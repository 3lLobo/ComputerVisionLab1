function [keypointmatch ] = creating_keypoints( image1_loc, image2_loc)
    % Mostly according this article: http://www.vlfeat.org/overview/sift.html
    I_1 = imread(image1_loc, 'pgm');
    I_2 = imread(image2_loc, 'pgm');
    
    
    [f1,d1] = vl_sift(single(I_1)) ;
    [f2,d2] = vl_sift(single(I_2)) ;
    
    % Shows 50 random descriptors, random selection of them all
    figure;
    imshow(I_1);
    perm = randperm(size(f1,2)) ;
    sel = perm(1:50) ;
    h1 = vl_plotframe(f1(:,sel)) ;
    h2 = vl_plotframe(f1(:,sel)) ;
    set(h1,'color','k','linewidth',3) ;
    set(h2,'color','y','linewidth',2) ;
    
    h3 = vl_plotsiftdescriptor(d1(:,sel),f1(:,sel)) ;
    set(h3,'color','g') ;
    
    % Shows random 50 descriptors
    figure;
    imshow(I_2);
    perm = randperm(size(f2,2)) ;
    sel = perm(1:50) ;
    h1 = vl_plotframe(f2(:,sel)) ;
    h2 = vl_plotframe(f2(:,sel)) ;
    set(h1,'color','k','linewidth',3) ;
    set(h2,'color','y','linewidth',2) ;
    h3 = vl_plotsiftdescriptor(d2(:,sel),f2(:,sel)) ;
    set(h3,'color','g') ;
    
    % Finds matches of the descriptors
    [matches, scores] = vl_ubcmatch(d1, d2);
end