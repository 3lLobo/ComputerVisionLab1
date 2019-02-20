function [ height_map ] = construct_surface( p, q, path_type )
%CONSTRUCT_SURFACE construct the surface function represented as height_map
%   p : measures value of df / dx
%   q : measures value of df / dy
%   path_type: type of path to construct height_map, either 'column',
%   'row', or 'average'
%   height_map: the reconstructed surface


if nargin == 2
    path_type = 'average';
end

[h, w] = size(p);
height_map = zeros(h, w);

switch path_type
    case 'row'
        % =================================================================
        % YOUR CODE GOES HERE
        % top left corner of height_map is zero
        % for each pixel in the left column of height_map
        %   height_value = previous_height_value + corresponding_q_value
        
        % for each row
        %   for each element of the row except for leftmost
        %       height_value = previous_height_value + corresponding_p_value
        
        for x = 1:h-1
            height_map(x+1,1) = height_map(x,1) + q(x+1,1);
        end
        for x = 1:h
            for y = 1:w-1
                height_map(x,y+1) = height_map(x,y) + p(x,y+1);    
            end
        end
                
        % =================================================================
               
    case 'row'
        for y = 1:w-1
            height_map(1,y+1) = height_map(1,y) + p(1,y+1);
        end
        
        for y = 1:w
            for x = 1:h-1
                height_map(x+1,y) = height_map(x,y) + q(x+1,y);
            end
        end
        
        % =================================================================
        % YOUR CODE GOES HERE
        

        % =================================================================
          
    case 'average'
        
        % =================================================================
        % YOUR CODE GOES HERE
        
        clm = zeros(h, w);
        rws = zeros(h, w);
        
        for x = 1:h-1
            clm(x+1,1) = clm(x,1) + q(x+1,1);
        end
        for x = 1:h
            for y = 1:w-1
                clm(x,y+1) = clm(x,y) + p(x,y+1);    
            end
        end
                for y = 1:w-1
            rws(1,y+1) = rws(1,y) + p(1,y+1);
        end
        
        for y = 1:w
            for x = 1:h-1
                rws(x+1,y) = rws(x,y) + q(x+1,y);
            end
        end
        height_map = (clm + rws)./2;
        
        % =================================================================
end


end

