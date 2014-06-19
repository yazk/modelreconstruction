function [  ] = Draw3DPoints( XList )

numPoints = size(XList,2);

clf;
hold on;

for i=1:numPoints
    X = XList(:,i);
    plot3(X(1),X(2),X(3), 'r.');
    text(X(1),X(2),X(3), num2str(i));
end;

hold off;

axis equal;