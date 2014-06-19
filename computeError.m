function [ error ] = computeError( pLeft, pRight, F )

numPoints = size(pLeft, 2);

error = 0;
for i=1:numPoints
    error = error + abs(pRight(:,i)' * F * pLeft(:,i));
    %disp(abs(pRight(:,i)' * F * pLeft(:,i)));
end;

error = error / numPoints;