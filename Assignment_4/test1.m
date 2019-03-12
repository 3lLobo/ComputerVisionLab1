clc
clear all

I = im2single(imread('boat1.pgm'));

[f,d] = vl_sift(I) ;

perm = randperm(size(f,2)) ;
sel = perm(1:50) ;

%h3 = vl_plotsiftdescriptor(d(:,sel),f(:,sel)) ;
%set(h3,'color','g') ;

% Image two

I2 = im2single(imread('boat2.pgm'));
imshow([I,I2])


[f2,d2] = vl_sift(I2) ;
for l = 1:size(f2,2)
    f2(1,l)=f2(1,l)+size(I,2);
    disp(f2(1,l))
end
perm2 = randperm(size(f2,2)) ;
sel2 = perm2(1:50) ;
h12 = vl_plotframe(f2(:,sel2)) ;
h22 = vl_plotframe(f2(:,sel2)) ;
h1 = vl_plotframe(f(:,sel)) ;
h2 = vl_plotframe(f(:,sel)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','b','linewidth',2) ;

set(h12,'color','k','linewidth',3) ;
set(h22,'color','y','linewidth',2) ;

%h32 = vl_plotsiftdescriptor(d2(:,sel2),f2(:,sel2)) ;
%set(h32,'color','r') ;