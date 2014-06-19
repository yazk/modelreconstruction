function [pLeft, pRight] = removeRadialDistortion(pLeft, pRight, fc, cc, alpha_c, kc)
% normalize(..) is from camera calibration toolbox
% Source: http://www.vision.caltech.edu/bouguetj/calib_doc/htmls/parameters.html

numPoints = size(pLeft,2);

for i=1:numPoints
    x_kk = pLeft(:,i);
    x_n = normalize(x_kk,fc,cc,kc,alpha_c);
    x_n = [x_n(1)*fc(1) + cc(1); x_n(2)*fc(2) + cc(2); 1];
    %x_n = [x_n; 1];
    pLeft(:,i) = x_n;
    
    x_kk = pRight(:,i);
    x_n = normalize(x_kk,fc,cc,kc,alpha_c);
    x_n = [x_n(1)*fc(1) + cc(1); x_n(2)*fc(2) + cc(2); 1];
    %x_n = [x_n; 1];
    pRight(:,i) = x_n;
end;