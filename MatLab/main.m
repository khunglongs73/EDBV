% contains all calls to further functionality
% -> is the entry-point to the processing pipeline

function main()


% clear output, read the inputfile and create the outputfile
close all;
clear global;
clc;

% flag for debug output
debug = 1;

fileTypes = {'*.jpg;*.tif;*.png;*.gif','All Image Files';'*.*','All Files' };

[FileName,PathName] = uigetfile(fileTypes, 'File Selector');


disp(['Try to open file: ' PathName FileName])
imgOri = imread([PathName FileName]);
imgPath = imgOri;


% split color-channels (R, G, Grey) and find path-start
[imgRed, imgGreen, imgGrey, pathStart] = splitChannels(imgOri);

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
[imgGrey] = highContrastGrey(imgGrey);


% create binary-image
[imgBinary] = binaryImage(imgGrey);


% sobel
[imgYSobel imgXSobel] = sobelGradient(imgGrey);

if debug==1  
    subplot(1,2,1);
    imshow(imgYSobel);
    title('imgYSobel');

    subplot(1,2,2);
    imshow(imgXSobel);
    title('imgXSobel');
    
    uiwait;
end

% plegde -> finding the actual way
[imgPath] = pledgePath(imgBinary, imgYSobel, imgXSobel, pathStart, imgGreen, imgOri);


% output of the result
subplot(1,2,1);
imshow(imgOri);
title('ORIGINAL');

subplot(1,2,2);
imshow(imgPath);
title('WITH PATH');

end