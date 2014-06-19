function [] = DrawBackProjection(XList,P1,P2)

clf;

numPoints = size(XList,2);
image1 = imread('left.jpg');
image2 = imread('right.jpg');
imageCols = size(image1,2);
imshow([image1 image2]);

hold on;

offset = imageCols;

for i=1:numPoints
    pLeftPt = P1 * XList(:,i);
    pRightPt = P2 * XList(:,i);
    
    pLeftPt = pLeftPt / pLeftPt(3);
    pRightPt = pRightPt / pRightPt(3);
    
    % Image Points
    text(pLeftPt(1), pLeftPt(2), num2str(i), 'BackgroundColor', 'White');
    text(pRightPt(1)+offset, pRightPt(2), num2str(i), 'BackgroundColor', 'White');
    plot(pLeftPt(1), pLeftPt(2), 'r.');
    plot(pRightPt(1)+offset, pRightPt(2), 'r.');
    
    % Correspondence
    line([pLeftPt(1) pRightPt(1)+offset], [pLeftPt(2) pRightPt(2)], 'Color', 'Red');
end;

hold off;