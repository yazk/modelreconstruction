function [new_points1, new_points2, X3D] = optimalTriangulation(F,...
    points1, points2, K1, K2, R, T)

% INPUTS:
% F => fundamental matrix
% points1, points2 => point matches from left and right camera
% K1, K2 => intrinsic matrix (either in pixels or mm)
% R => Rotation matrix (according to Rodrigue's formula)
% T => Translation (either normalise or with scale)

% OUTPUTS
% new_points1, new_points2 => noise free 2D points from left and right
% cameras
% X3D => Recovered 3D points

% NOTE: R and T describes the transformation for the right camera to the
% left camera

% Multiview Geometery in Computer Vision 2ed (Hartley/Zisserman)
% Algorithm 12.1 (p318)
% GAC (April, 2010)



P1 = K1 * [eye(3), [0 0 0]'];
P2 = K2 * [R, T];

new_points1 = zeros(size(points1));
new_points2 = zeros(size(points2));
X3D = zeros(size(points1,1),4);

for p = 1:size(points1,1)
    
    x1 = points1(p,1);
    y1 = points1(p,2);
    x2 = points2(p,1);
    y2 = points2(p,2);
    
    %STEP i
    % The inverse is considered in T1 and T2
    iT1 = [1 0 x1;...
        0 1 y1;
        0 0 1];
    
    iT2 = [1 0 x2;...
        0 1 y2;...
        0 0 1];
    
    %STEP ii
    TFT = iT2'*F*iT1;

    %STEP iii
    % Compute the right epipole e1 from F * e1 = 0
    [U,S,V] = svd(TFT);
    
    scale = sqrt(V(1,3)*V(1,3) + V(2,3)*V(2,3));
    e1 = V(:,3)./scale;
    
    if e1(3) < 0
        e1 = -e1;
    end
    
    % Compute the left epipole e2 from e2' * F = 0  =>  F' * e2 = 0
    TFTt = TFT';
    [U,S,V] = svd(TFTt);
    
    scale = sqrt(V(1,3)*V(1,3) + V(2,3)*V(2,3));
    
    e2 = V(:,3)./scale;
    if e2(3) < 0
        e2 = -e2;
    end
    
    %STEP iv
    R1 = [e1(1) e1(2) 0;...
        -e1(2) e1(1) 0;...
        0 0 1];
    R2 = [e2(1) e2(2) 0;...
        -e2(2) e2(1) 0;...
        0 0 1];
    
    %STEP v
    RTFTR = R2*TFT*R1';
    
    %STEP vi
    f1 = e1(3,1);
    f2 = e2(3,1);
    a = RTFTR(2,2);
    b = RTFTR(2,3);
    c = RTFTR(3,2);
    d = RTFTR(3,3);
    
    %STEP vii
    polynomial(1,7) = b * d * (b*c - a*d);
    polynomial(1,6) = b^4 - a^2 * d^2 + d^4 * f2^4 + b^2 * (c^2 + 2 * d^2 * f2^2);
    polynomial(1,5) = -a^2 * c * d + a * b * (4 * b^2 + c^2 - 2 * d^2 *...
        (f1^2 - 2 * f2^2)) + 2 * c * d * (2 * d^2 * f2^4 + b^2 * (f1^2 + 2 * f2^2));
    polynomial(1,4) = 2 * (4 * a * b * c * d * f2^2 + a^2 * (3 * b^2 +...
        d^2 * (-f1^2 + f2^2)) + c^2 * (3 * d^2 * f2^4 + b^2 * (f1^2 + f2^2)));
    polynomial(1,3) = 4 * a^3 * b - 2 * a^2 * c * d * (f1^2 - 2 * f2^2) +...
        c * d * (b^2 * f1^4 + 4 * c^2 * f2^4) + a * b * (-d^2 * f1^4 + 2 *...
        c^2 * (f1^2 + 2 * f2^2));
    polynomial(1,2) = a^4 + b^2 * c^2 * f1^4 + c^4 * f2^4 + a^2 * (-d^2 *...
        f1^4 + 2 * c^2 * f2^2);
    polynomial(1,1) = a * c * (b * c - a * d) * f1^4;
    
    % Solve g(t) for t to get 6 roots
    results = roots(polynomial);
    
    %STEP viii
    t_min = Inf;
    s_val = 1./(f1^2) + (c^2)/(a^2 + f2^2 * c^2);
    
    for ti = 1:6
        t = real(results(ti,1));
        s = (t^2)/(1 + f1^2 * t^2) + ((c*t + d)^2)/((a*t + b)^2 + f2^2 * (c*t + d)^2)^2;
        if (s < s_val)
            s_val = s;
            t_min = t;
        end
    end

    %STEP ix
    l1 = [t_min*f1,1,-t_min];
    l2 = [-f2*(c*t_min + d), a*t_min + b, c*t_min + d];
      
    xhat1 = [-l1(1)*l1(3), -l1(2)*l1(3), l1(1)^2 + l1(2)^2];
    xhat2 = [-l2(1)*l2(3), -l2(2)*l2(3), l2(1)^2 + l2(2)^2];
    
    %STEP x
    new_xhat1 = iT1*R1'*xhat1';
    new_xhat2 = iT2*R2'*xhat2';
    
    new_points1(p,1) = new_xhat1(1)/new_xhat1(3);
    new_points1(p,2) = new_xhat1(2)/new_xhat1(3);
    
    new_points2(p,1) = new_xhat2(1)/new_xhat2(3);
    new_points2(p,2) = new_xhat2(2)/new_xhat2(3);

    new_points1(p,:);
    new_points2(p,:);
    
    %STEP xi
    % DLT
    
    A =[new_points1(p,1) * P1(3,:) - P1(1,:) ;
        new_points1(p,2) * P1(3,:) - P1(2,:) ;
        new_points2(p,1) * P2(3,:) - P2(1,:) ;
        new_points2(p,2) * P2(3,:) - P2(2,:) ];
    
    %Uncomment to only use DLT
%     A = [points1(p,1) * P1(3,:) - P1(1,:) ;
%         points1(p,2) * P1(3,:) - P1(2,:) ;
%         points2(p,1) * P2(3,:) - P2(1,:) ;
%         points2(p,2) * P2(3,:) - P2(2,:) ];
    
    A(1,:) = A(1,:)/norm(A(1,:));
    A(2,:) = A(2,:)/norm(A(2,:));
    A(3,:) = A(3,:)/norm(A(3,:));
    A(4,:) = A(4,:)/norm(A(4,:));
  
    [Ua Ea Va] = svd(A);
    X = Va(:,end);
    X3D(p,:) = X ./ X(4);   % 3D Point

    
end
