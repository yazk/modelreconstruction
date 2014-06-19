function [] = DrawCameras(C1,C2)

hold on;

text(C1(1), C1(2), C1(3), 'Camera 1', 'BackgroundColor', 'White');
text(C2(1), C2(2), C2(3), 'Camera 2', 'BackgroundColor', 'White');
plot3(C1(1), C1(2), C1(3), 'b*');
plot3(C2(1), C2(2), C2(3), 'b*');

%Optical axis
%line([C2(1) C2(1)], [C2(2) C2(2)], [C2(3) C2(3)+1], 'Color', 'Red');
%line([C1(1) C1(1)], [C1(2) C1(2)], [C1(3) C1(3)+1], 'Color', 'Red');

% XYZ axis
% hold on;
% line([0 1],[0 0],[0 0], 'Color', 'Red');
% line([0 0],[0 1],[0 0], 'Color', 'Green');
% line([0 0],[0 0],[0 1], 'Color', 'Blue');
% hold off;

hold off;

end