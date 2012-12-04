function [path] = pledgePath(imgBinary, imgYSobel, imgXSobel, pathStart, pathEnd, imgGreen, imgOri)
% claculates the way throgh the maze with the algorithm of Pledge
% 
% INPUT
% imgBinary ... binary image (1=corridor, 0=wall)
% imgYSobel ... Sobel gradient - in Y direction 
% imgXSobel ... Sobel gradient - in X direction
% pathStart ... (x,y)-coordinates of the starting-point of the path
% imgGreen  ... marks the target-area; necessary for termination
% imgOri    ... original image
% 
% OUTPUT
% path ... the path out - sketched onto original image

path = imgOri;

% up=0, right=1, down=2, left=3
direction=2;

% count turns
counter=0;

% current position 
cursor=pathStart;

% Flags
walkStraightFlag=true;  % alongside a wall or straight
collisionFlag=false;    % is there a wall ahead
foundExitFlag=false;    % have we found the exit

%disp(imgBinary);
%uiwait;

status=0;
while(foundExitFlag~=true) 

    status=status+1;
    
    if(walkStraightFlag)
        [cursor, path] = pledgeCursorShift(cursor, path, direction);
        collisionFlag = pledgeDetectCollision(cursor, imgBinary, direction);
    else
        
    end


    % found the exit ?
   % if(pathEnd(1,1) < cursor(1,1) < pathEnd(2,1))
   %     if(pathEnd(1,2) < cursor(1,2) < pathEnd(2,2))
            
    if(pathEnd(1,1) < cursor(1,1) && cursor(1,1) < pathEnd(2,1))
        if(pathEnd(1,2) < cursor(1,2) && cursor(1,2) < pathEnd(2,2))
            foundExitFlag=true;
            disp('Exit found');
        end
    end
    
    
    if(collisionFlag)
        foundExitFlag=true;
        disp('Collision detected');
    end
    
    % output current status every 50px
    if(status==50)
        imshow(path);
        uiwait;
        status=0;
    end
end


end