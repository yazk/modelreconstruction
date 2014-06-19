function [E] = EssentialMatrix(F, K)

% Recover essential matrix
E = K' * F * K;

[UE, EE, VE] = svd(E);
E = UE * diag([1,1,0]) * VE';

%EE_avg = EE(1) + EE(2) / 2;
%EE = [EE_avg 0 0; 0 EE_avg 0; 0 0 0];
%EE = [1 0 0; 0 1 0; 0 0 0];