function [ normLeft, normRight ] = getNormalization( pLeft, pRight )
% See Cyganek p.48

numPoints = size(pLeft,2);

% Find left and right mean
sumLeft = 0;
sumRight = 0;
for i=1:numPoints
    sumLeft = sumLeft + pLeft(:,i);
    sumRight = sumRight + pRight(:,i);
end;

meanLeft = sumLeft / numPoints;
meanRight = sumRight / numPoints;

% Find left and right variance
sumLeft = 0;
sumRight = 0;
for i=1:numPoints
    pLeftCur = pLeft(:,i);
    pRightCur = pRight(:,i);

    sumLeft = sumLeft + [(pLeftCur(1) - meanLeft(1))^2; (pLeftCur(2) - meanLeft(2))^2];
    sumRight = sumRight + [(pRightCur(1) - meanRight(1))^2; (pRightCur(2) - meanRight(2))^2];
end;

varianceLeft = [1 / sqrt(sumLeft(1) / numPoints);
                1 / sqrt(sumLeft(2) / numPoints)];

varianceRight = [1 / sqrt(sumRight(1) / numPoints);
                1/sqrt(sumRight(2) / numPoints)];

% Put together into normalization matrix for left and right
normLeft = [varianceLeft(1), 0, -meanLeft(1)*varianceLeft(1);
            0, varianceLeft(2), -meanLeft(2)*varianceLeft(2);
            0,0,1 ];
        
normRight = [varianceRight(1), 0, -meanRight(1)*varianceRight(1);
            0, varianceRight(2), -meanRight(2)*varianceRight(2);
            0,0,1 ];

% meanLeft
% meanRight
% varianceLeft
% varianceRight
% normLeft
% normRight