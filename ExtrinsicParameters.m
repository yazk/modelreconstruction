function [R, T] =  ExtrinsicParameters(E, F, pLeft, pRight)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Check for camera being in front of the points
% p. 257-259
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[UE, EE, VE] = svd(E);

W = [0 -1 0; 1 0 0; 0 0 1];

P1 = [eye(3), eye(3,1)];
P2 = zeros(3,4,4);


% Result 9.19
R1 = UE * W * VE';
R2 = UE * W' * VE';
T1 = UE(:,end) / max(abs( UE(:,end) ));
T2 = -UE(:,end) / max(abs( UE(:,end) ));

%T1 = UE(:,end);
%T2 = -UE(:,end);

P2(:,:,1) = [R1, T1];
P2(:,:,2) = [R1, T2];
P2(:,:,3) = [R2, T1];
P2(:,:,4) = [R2, T2];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Need only 1 pair of points to check
% if point is front of both cameras
x1 = pLeft(:,1);
x2 = pRight(:,1);

% Do depth check
if ( isInFrontOfBothCameras(x1,x2,F,P1,P2(:,:,1)) == 1)
    R = R1;
    T = T1;
elseif ( isInFrontOfBothCameras(x1,x2,F,P1,P2(:,:,2)) == 1)
    R = R1;
    T = T2;
elseif ( isInFrontOfBothCameras(x1,x2,F,P1,P2(:,:,3)) == 1)
    R = R2;
    T = T1;
elseif ( isInFrontOfBothCameras(x1,x2,F,P1,P2(:,:,4)) == 1)
    R = R2;
    T = T2;
else
    disp('Criticial Error, R and T not assigned');
end;