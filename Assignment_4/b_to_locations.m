function [x, y] = b_to_locations(b)
    % retrieve x and y locations from b matrix
    [n, ~] = size(b);
    x = b(1:(n/2), 1).';
    y = b((n/2) + 1:end, 1).';
end