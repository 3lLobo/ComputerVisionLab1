function [matches, scores, fa, fb] = keypoint_matching(Im1,Im2)
    Ia = im2single(Im1);
    Ib = im2single(Im2);
    [fa, da] = vl_sift(Ia) ;
    [fb, db] = vl_sift(Ib) ;
    [matches, scores] = vl_ubcmatch(da, db) ;

end