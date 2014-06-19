function [epipole1 epipole2] = drawEpipolarLines( pLeft, pRight, F )

clf;

numPoints = size(pLeft,2);

image1 = imread('left.jpg');
image2 = imread('right.jpg');
imageCols = size(image1,2);

imshow([image1 image2]);

hold on;

offset = imageCols;
x = 0:offset;

for i=1:numPoints
    pLeftPt = pLeft(:,i);
    pRightPt = pRight(:,i);
        
    l2 = F * pLeftPt;
    l1 = F' * pRightPt;

    % Epipolar line (left image)
    y = -(l1(1)*x + l1(3)) / l1(2);
    plot(x,y, 'Color', 'Blue');
    
    % Epipolar line (right image)
    y = -(l2(1)*x + l2(3)) / l2(2);
    plot(x+offset,y, 'Color', 'Blue');
    
    % Image Points
    text(pLeftPt(1), pLeftPt(2), num2str(i), 'BackgroundColor', 'White');
    text(pRightPt(1)+offset, pRightPt(2), num2str(i), 'BackgroundColor', 'White');
    plot(pLeftPt(1), pLeftPt(2), 'r.');
    plot(pRightPt(1)+offset, pRightPt(2), 'r.');
    
    % Correspondence
    %line([pLeftPt(1) pRightPt(1)+offset], [pLeftPt(2) pRightPt(2)], 'Color', 'Red');
end;

epipole1 = null(F);
epipole2 = null(F');

epipole1 = epipole1 / epipole1(3)
epipole2 = epipole2 / epipole2(3)

plot(epipole1(1)       , epipole1(2), 'y.');
plot(epipole2(1)+offset, epipole2(2), 'y.');

hold off;