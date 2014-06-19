function [ x1List, x2List ] = getCorrespondences()

%SIFT

% -------------------------------------------------------------------------


Ia = imread('left.jpg');
Ib = imread('right.jpg');

% vl_feat tool box
cd vlfeat\toolbox\demo\

%Ia = vl_imsmooth(im2double(Ia),8);
%Ib = vl_imsmooth(im2double(Ib),8);

% --------------------------------------------------------------------
%                                           Extract features and match
% --------------------------------------------------------------------
% http://www.vlfeat.org/mdoc/VL_SIFT.html
%'PeakThresh', 0, 'EdgeThresh',   10, 'FirstOctave', 0
[fa,da] = vl_sift(im2single(rgb2gray(Ia)));
[fb,db] = vl_sift(im2single(rgb2gray(Ib)));

[matches, scores] = vl_ubcmatch(da,db); % 1.5 default threshold

[drop, perm] = sort(scores, 'descend') ;
matches = matches(:, perm) ;
scores  = scores(perm);

% % % figure(1) ; clf ;
% % % imagesc(cat(2, Ia, Ib)) ;
% % % 
% % % xa = fa(1,matches(1,:)) ;
% % % xb = fb(1,matches(2,:)) + size(Ia,2) ;
% % % ya = fa(2,matches(1,:)) ;
% % % yb = fb(2,matches(2,:)) ;
% % % 
fa_copy = fa;
fb_copy = fb;
% % % 
% % % hold on ;
% % % h = line([xa ; xb], [ya ; yb]) ;
% % % set(h,'linewidth', 2, 'color', 'b') ;
% % % 
% % % vl_plotframe(fa(:,matches(1,:))) ;
% % % fb(1,:) = fb(1,:) + size(Ia,2) ;
% % % vl_plotframe(fb(:,matches(2,:))) ;
% % % axis equal ;
% % % axis off  ;
% % % 
% % % vl_demo_print('sift_match_1', 1) ;


% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% go back to working directory
cd ..\..\..\

xa = fa_copy(1,matches(1,:));
ya = fa_copy(2,matches(1,:));

xb = fb_copy(1,matches(2,:)); %- size(Ia,2);
yb = fb_copy(2,matches(2,:));

numPoints = size(xa,2)
x1List = [xa;ya;ones(1,numPoints)];
x2List = [xb;yb;ones(1,numPoints)];
