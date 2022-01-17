% Charles Liu
%11/02/2021
%usage: truncate a matrix by throwing away the end-areas that contain zeros
% INPUTS:
%   matrix3D - (:,;,:) matrix, the audio data feature
%   index - the third dimension of matrix3D
% RETURNS:
%   mat-  the truncated matrix


function mat = truncSparse(matrix3D,index);
    [a,b,c] = size(matrix3D);
    row = 0;
    for i = 1:a;
        if all(matrix3D(i:i+10,:,index) == 0);
        %if all(matrix3D(i,:,index) <= 1e-3);
            break
        end
        row = row+1;
    end
        mat = matrix3D(1:row,:,index);
   
end