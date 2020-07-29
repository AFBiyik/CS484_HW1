% Author: Ahmet Furkan Biyik
% ID: 21501084
% Date: 23.10.2019
% I used the definition in the slides

function [output] = dilation ( source_image , struct_el )
%dilation Dilate image.
%    binary_image = dilation(source_image , struct_el) 
%    dilate the binary source image source_image.
%    binary_image, returning the dilated image.
%    struct_el is a structuring element object as a logical matrix or
%    as a value returned by the STREL function.

    % check types
    if ( ~ismatrix(source_image))
        error('Source image should be matrix');
    elseif (isa(struct_el, 'strel'))
        struct_el = struct_el.Neighborhood;
    elseif (~ismatrix(source_image))
        error('Structural element should be strel or matrix');
    end

    [sRows, sColumns] = size( struct_el ); % structuring elemenet dimensions
    center = [ceil(sRows/2) ceil(sColumns/2)]; % origin of structuring element at center
    [noOfRows, noOfColumns] = size(source_image); % source �mage dimensions
    output = false(noOfRows, noOfColumns); % output variable filled with logical 0s

    % iterate each row of source image
    for i = 1:noOfRows
        % iterate each column of source image
        for j = 1:noOfColumns
            d = 0; % (i, j) value of output
            flag = 0; % to break the loops
            
            % iterate each row of structuring element
            for k = 1:sRows
                % iterate each column of structuring element
                for l = 1:sColumns
                    % struct_el is false
                    if (struct_el(k,l) == 0)
                        continue;
                    end
                    
                    % stay in matrix bounds
                    if (i+k-center(1)>0 && ...
                        j+l-center(2)>0 && ...
                        i+k-center(1)<noOfRows && ...
                        j+l-center(2)<noOfColumns)
                    
                        % calculate d by checking each cell in structuring
                        % element and corresponding position in source
                        % image
                        d = d | ...
                            (struct_el(k,l) && source_image(i+k-center(1),j+l-center(2)));
                        
                        % if d is true no need to check other elements
                        if (d)
                           flag = 1;
                           break;
                        end
                    end
                end % end structuring element column loop
                % break loop
                if (flag)
                   break; 
                end
            end % end structuring element row loop
            % set d
            output(i,j) = d;
        end % end source image column loop
    end % end source image row loop
end
