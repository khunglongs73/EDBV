% contains all calls to further functionality
% -> is the entry-point to the processing pipeline

function main()

% flag for debug output
debug = 0;

% flag for animation
animate = 1;


% clear output, read the inputfile and create the outputfile
close all;
clear global;
clc;



fileTypes = {'*.jpg;*.tif;*.png;*.gif','All Image Files';'*.*','All Files' };

[FileName,PathName] = uigetfile(fileTypes, 'File Selector');


disp(['Try to open file: ' PathName FileName])


%convert gif files
if(isempty(regexpi(FileName, '.gif'))~=true)
    [imgOri, cmap] = imread([PathName FileName]);
    imgOri = ind2rgb(imgOri, cmap);
else
    imgOri = imread([PathName FileName]);
    imgOri = im2double(imgOri);
end

imgPath = imgOri;
imgMedian = imgOri;

imgMedian(:,:,1) = medianFilter(imgMedian(:,:,1));
imgMedian(:,:,2) = medianFilter(imgMedian(:,:,2));
imgMedian(:,:,3) = medianFilter(imgMedian(:,:,3));


% split color-channels (R, G, Grey) and find path-start
[imgRed, imgGreen, imgGrey, pathStart] = splitChannels(imgMedian);

% find exit of maze
pathEnd = findMazeExit(imgGreen);


if debug==1  
    subplot(1,3,1);
    imshow(imgRed);
    title('imgRed');

    subplot(1,3,2);
    imshow(imgGreen);
    title('imgGreen');

    subplot(1,3,3);
    imshow(imgGrey);
    title('imgGrey');
    
    uiwait;
end


% optimize greyscale-image
% Rundet die Kanten ab & erschwert dadurch die Findung des Pfades
%[imgGrey] = highContrastGrey(imgGrey);

% create binary-image
[imgBinary] = binaryImage(imgGrey);


% sobel
[imgYSobel imgXSobel] = sobelGradient(imgGrey);

if debug==1  
    subplot(1,2,1);
    imshow(imgYSobel);
    title('imgYSobel');

    imshow(imgBinary);
    title('imgBinary');

    subplot(1,2,2);
    imshow(imgXSobel);
    title('imgXSobel');
    
    uiwait;
end

% plegde -> finding the actual way
[imgPath] = pledgePath(imgBinary, imgYSobel, imgXSobel, pathStart, pathEnd, imgGreen, imgOri, animate);


% output of the result
subplot(1,2,1);
imshow(imgOri);
title('ORIGINAL');

subplot(1,2,2);
imshow(imgPath);
title('WITH PATH');

end