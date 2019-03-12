clc
clear all

Im1 = imread('boat1.pgm');
Im2 = imread('boat2.pgm');

[matches, scores, fa, fb] = keypoint_matching(Im1,Im2);

imshow([Im1,Im2]);
h1 = vl_plotframe(fa(:,matches(1,1:10))) ;
h2 = vl_plotframe(fa(:,matches(1,1:10))) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;

for l = 1:size(fb,2)
    fb(1,l)=fa(1,l)+size(Im1,2);
    
end

h1 = vl_plotframe(fb(matches(1,1:10))) ;
h2 = vl_plotframe(fb(:,sel)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;