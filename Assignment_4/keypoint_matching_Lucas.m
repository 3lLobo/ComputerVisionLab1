function [I_1, I_2, f1, d1, f2, d2, matches, scores] = creating_keypoints( image1_loc, image2_loc)
    % Mostly according this article: http://www.vlfeat.org/overview/sift.html
    I_1 = imread(image1_loc, 'pgm');
    I_2 = imread(image2_loc, 'pgm');
    
    
    [f1,d1] = vl_sift(single(I_1)) ;
    [f2,d2] = vl_sift(single(I_2)) ;
    
    % Finds matches of the descriptors
    [matches, scores] = vl_ubcmatch(d1, d2);
    matches(1:2, 1:10)
end