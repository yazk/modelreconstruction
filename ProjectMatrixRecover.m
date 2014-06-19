function [ P1, P2 ] = ProjectMatrixRecover( R, t, K )
% http://en.wikipedia.org/wiki/Camera_resectioning

P1 = K * [eye(3), zeros(3,1)];
P2 = K * [R, t];