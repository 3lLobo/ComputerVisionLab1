% Shows 50 random descriptors, random selection of them all

[I_1, I_2, f1, d1, f2, d2, matches, scores] = keypoint_matching('boat1.pgm', 'boat2.pgm');

selection_a = matches(1, 1:10)
selection_b = matches(2, 1:10)

figure;
imshow(I_1);
h1 = vl_plotframe(f1(:,selection_a)) ;
h2 = vl_plotframe(f1(:,selection_a)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;
h3 = vl_plotsiftdescriptor(d1(:,selection_a),f1(:,selection_a)) ;
set(h3,'color','g') ;

% Shows random 50 descriptors
figure;
imshow(I_2);
h1 = vl_plotframe(f2(:,selection_b)) ;
h2 = vl_plotframe(f2(:,selection_b)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;
h3 = vl_plotsiftdescriptor(d2(:,selection_b),f2(:,selection_b)) ;
set(h3,'color','g') ;