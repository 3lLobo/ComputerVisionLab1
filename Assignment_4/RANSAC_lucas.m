function [transformationvector, newpositions, best_result] = RANSAC_lucas(fa, fb, matches, N, P)

    % Collecting all positions
    xa_full = fa(1, matches(1,:));
    xb_full = fb(1, matches(2,:));
    ya_full = fa(2, matches(1,:));
    yb_full = fb(2, matches(2,:));
    
    A_full = locations_to_A_matrix(xa_full, ya_full);

    % Easy to beat value.
    best_result = 9999999999999;

    for i=1:N
        % Creates random indexes in the range of the size of matches
        random_indices = randperm(size(matches, 2));
        selected_matches = matches(:, random_indices(1:P));

        % Selecting the corresponding positions in the images
        xa = fa(1, selected_matches(1,:));
        xb = fb(1, selected_matches(2,:));
        ya = fa(2, selected_matches(1,:));
        yb = fb(2, selected_matches(2,:));

        % Initting the A matrix, 1:n are x positions, n+1:end are y positions
        A = locations_to_A_matrix(xa, ya);
        b = locations_to_b_matrix(xb, yb);

        % Calculating x
        x = pinv(A) * b;

        % Calculating on all positions
        [x_pred, y_pred] = b_to_locations((A_full * x));
        distances = [x_pred; y_pred] - [xb_full; yb_full];
        inliers = sum(sqrt(sum(distances .^2)) >= 10);
        if inliers < best_result
            best_result = inliers;
            transformationvector = x;
            newpositions = [x_pred; y_pred];
        end

    end

end


function b = locations_to_b_matrix(x, y)

    [~, n] = size(x);
    % Initting the b vector, with the supposed to achieve possitions
    % 1:n are x positions, n+1:end are y positions
    b = zeros(2*n, 1);
    b(1:n, 1) = x;
    b(n+1:end, 1) = y;
end
