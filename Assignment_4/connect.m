clc
clear all
close all

Im1 = imread('boat1.pgm');
Im2 = imread('boat2.pgm');
imshow([Im1,Im2]);
hold

[matches, scores, fa, fb] = keypoint_matching(Im1,Im2);

subset = 10;
msize = size(matches,2);

mpoints = randsample(msize, subset);
matches = matches(:,mpoints);
favec = fa(:,matches(1,:));
fbvec = fb(:,matches(2,:));
fbvec(1,:) = fbvec(1,:) + size(Im1,2);

ha = vl_plotframe(favec);
set(ha,'color','y','linewidth',3) ;
hb = vl_plotframe(fbvec);
set(hb,'color','y','linewidth',3) ;

for n = 1:subset
    connector = line([favec(1,n);fbvec(1,n)],[favec(2,n);fbvec(2,n)]);
    set(connector,'linewidth', 1, 'color', rand(1,3));
end



