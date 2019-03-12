function A = locations_to_A_matrix(x, y)

    [~, n] = size(x);

    % Initting the A matrix, 1:n are x positions, n+1:end are y positions
    A = zeros(2*n, 6);
    A(1:n, 5) = 1;
    A(n+1:end, 6) = 1;
    A(1:n, 1) = x;
    A(1:n, 2) = y;
    A(n+1:end, 3) = x;
    A(n+1:end, 4) = y;
end