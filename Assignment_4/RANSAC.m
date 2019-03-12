function [M, T, inliners] = RANSAC(fa,fb,matches,N,K)

subset = K;
msize = size(matches,2);
max_in = 0;
size_a = size(fa,2);
size_b = size(fb,2);
if size_a < size_b
    uni_max = size_a;
else
    uni_max = size_b;
end

for n = 1:N
    mpoints = randsample(msize, subset);
    matches1 = matches(:,mpoints);
    favec = fa(:,matches1(1,:));
    fbvec = fb(:,matches1(2,:));
    
    xa = favec(1,:);
    ya = favec(2,:);
    xb = fbvec(1,:);
    yb = fbvec(2,:);
    
    xall = fa(1,1:uni_max);
    yall = fa(2,1:uni_max);
    xbll = fb(1,1:uni_max);
    ybll = fb(2,1:uni_max);
    
    A = zeros(K*2, 6);
    A(1:K,1) = xa;
    A(K+1:K*2,3) = xa;
    A(1:K,2) = ya;
    A(K+1:K*2,4) = ya;
    A(1:K,5) = 1;
    A(K+1:K*2,6) = 1;
    
    b = zeros(K*2,1);
    b(1:K,1) = xb;
    b(K+1:K*2,1) = yb;
    
    x = pinv(A) * b;
    M1 = x(1:4);
    T1 = x(5:6);
    M1 = reshape(M1,2,2);
    
    check = M1*[xall;yall]+T1;
    size(check)
    xbcheck = check(1,:) - xbll;
    ybcheck = check(2,:) - ybll;
    inliners1 = sqrt(xbcheck.^2 - ybcheck.^2) <= 10;
    in_total = sum(inliners1);
    if in_total > max_in
        max_in = in_total;
        inliners = inliners1;
        M = M1;
        T = T1;
    end 
end
end
    
    
    
    
    