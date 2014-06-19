function [result] = isInFrontOfBothCameras(x1,x2,F,P1,P2)
% Hartley/Zisserman
% 6.2.3 Depth of points
% Result 6.1 - p. 162-163

X = Triangulation(x1, x2, F, P1, P2);

% Second Camera
x2proj = P2 * X;
w = x2proj(3);
T = X(end);
m3n = sqrt(sum(P2(3,1:3).*P2(3,1:3)));
DepthCam2 = (sign(det(P2(:,1:3)))*w)/(T*m3n);

% First Camera
x1proj = P1 * X;
w = x1proj(3);
T = X(end);
m3n = sqrt(sum(P1(3,1:3).*P1(3,1:3)));
DepthCam1 = (sign(det(P1(:,1:3)))*w)/(T*m3n);


if (DepthCam1 > 0 && DepthCam2 > 0 )
    result = 1;
    return;
else
    result = 0;
    return;
end
    
end