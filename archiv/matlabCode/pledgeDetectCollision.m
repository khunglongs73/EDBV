function collisionFlag = pledgeDetectCollision(cursor, imgBinary, direction)
% Looks at the border of the current area in the current direction and sets
% a flag in case of a collision with a wall
% 
% INPUT
% cursor         ... (x,y) coord. of the area center
% imgBinary      ... binary represenation (wall=0, way=1)
% direction      ... top, left, bottom, right
% 
% OUTPUT
% collisionFlag  ... boolean - wall ahead

% move cursor according to direction


switch direction
    case 0 
        area=imgBinary(cursor(1,1)-2,[cursor(1,2)-2:cursor(1,2)+2]);
    case 1
     	area=imgBinary([cursor(1,1)-2:cursor(1,1)+2],cursor(1,2)+2);
        area=area.';
    case 2
        area=imgBinary(cursor(1,1)+2,[cursor(1,2)-2:cursor(1,2)+2]);
    case 3
        area=imgBinary([cursor(1,1)-2:cursor(1,1)+2],cursor(1,2)-2);
        area=area.';
end
    
mValue=mean(area);
    
    
% decide
if(mValue>0.5)
    collisionFlag=false;
else
    collisionFlag=true;
    
    % DEBUG STUFF
    %disp('__HIT A WALL__');
    %cursorArea=imgBinary([cursor(1,1)-2:cursor(1,1)+2],[cursor(1,2)-2:cursor(1,2)+2])
    %area
    %mValue
    %pause;

end


end
