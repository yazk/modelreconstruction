function [K, fc, cc, alpha_c, kc] = CalibrateCameras()
% Calibration results after optimization (with uncertainties):
% 
% Focal Length:          fc = [ 699.13458   701.11196 ] ± [ 1.05092   1.08272 ]
% Principal point:       cc = [ 393.51797   304.05914 ] ± [ 1.61832   1.27604 ]
% Skew:             alpha_c = [ 0.00180 ] ± [ 0.00042  ]   => angle of pixel axes = 89.89661 ± 0.02379 degrees
% Distortion:            kc = [ 0.05867   -0.28214   0.00131   0.00244  0.35651 ] ± [ 0.01228   0.09805   0.00060   0.00083  0.22340 ]
% Pixel error:          err = [ 0.19975   0.23023 ]
% 
% Note: The numerical errors are approximately three times the standard
% deviations (for reference).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Focal length = fc
% Principal point = cc
% Skew = alpha_c
% Distortion = kc
fc = [ 699.13458   701.11196 ];
cc = [ 393.51797   304.05914 ];
alpha_c = 0.00180;
kc = [ 0.05867   -0.28214   0.00131   0.00244  0.35651 ];

K = [fc(1), alpha_c*fc(1), cc(1); 0, fc(2), cc(2); 0, 0, 1]
%K = [700 0 400; 0 700 300; 0 0 1]