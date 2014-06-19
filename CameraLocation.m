function [C1, C2] = CameraLocation(P1,P2)

C1 = null(P1);
C2 = null(P2);

C1 = C1 / C1(4);
C2 = C2 / C2(4);

end