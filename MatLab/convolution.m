function[resConv] = convolution(image, kernel)

% 2D Convolution
% applies a kernel on a (image)matrix
%
% INPUT
% image     ... input matrix of the convolution
% kernel    ... kernel of the convolution
%
% OUTPUT    
% resConv   ... output matrix with applied conv. 
%               output is kernelsize - 1 smaller than the input

% get size of image and kernel
[iRow, iCol] = size(image);
[kRow, kCol] = size(kernel);

% calculate size for new matrix
newRows = iRow - kRow + 1;
newCols = iCol - kCol + 1;

resConv = zeros(newRows, newCols);      

% loop over kernel instead of input-matrix
% -> faster - makes better use of matlabs datastructures
for mr = 1:kRow          
    for mc = 1:kCol
        xpart = image(kRow-mr+1:iRow-mr+1, kCol-mc+1:iCol-mc+1);
        resConv = resConv + xpart * kernel(mr, mc);
    end
end


end