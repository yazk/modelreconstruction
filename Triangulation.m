function [ XList ] = Triangulation( pLeft, pRight, F, P1, P2 )
% Algorithm 12.1. The optimal triangulation method.

numPoints = size(pLeft,2);

XList = zeros(4, numPoints);

xhats1 = zeros(3, numPoints);
xhats2 = zeros(3, numPoints);

hold on;
for i=1:numPoints
     
     pLeftPt  =  pLeft(:,i);
     pRightPt =  pRight(:,i);
     
     pLeftPt = pLeftPt / pLeftPt(3);
     pRightPt = pRightPt / pRightPt(3);
     
     % i
     T1 = [1 0 -pLeftPt(1) ; 0 1  -pLeftPt(2); 0 0 1];
     T2 = [1 0 -pRightPt(1); 0 1 -pRightPt(2); 0 0 1];
     
     % ii
     Fnew = (T2^-1)' * F * T1^-1;
     
     % iii
     e1 = null(Fnew);
     e2 = null(Fnew');
     
     e1 = e1 / sqrt(e1(1)^2 + e1(2)^2); % norm(e1)
     e2 = e2 / sqrt(e2(1)^2 + e2(2)^2); % norm(e2)
     
     if ( e1(3) < 0 )
         e1 = -e1;
     end; % why?
     if ( e2(3) < 0 )
         e2 = -e2;
     end; % why?
     
     % iv
     R1 = [e1(1), e1(2), 0; -e1(2) e1(1) 0; 0 0 1];
     R2 = [e2(1), e2(2), 0; -e2(2) e2(1) 0; 0 0 1];
     
     % v
     Fnew = R2 * Fnew * R1';
     
     % vi
     f1 = e1(3);
     f2 = e2(3);
     a = Fnew(2,2);
     b = Fnew(2,3);
     c = Fnew(3,2);
     d = Fnew(3,3);
     
     % vii     
     gPolynomial = zeros(1,7);
     gPolynomial(1,1) = (-a*c*f1^4*(a*d - b*c)); % t^6
     gPolynomial(1,2) = (a^4 + 2*a^2*c^2*f2^2 - a^2*d^2*f1^4 + b^2*c^2*f1^4 + c^4*f2^4); % t^5
     gPolynomial(1,3) = (4*a^3*b - 2*a^2*c*d*f1^2 + 4*a^2*c*d*f2^2 + 2*a*b*c^2*f1^2 + 4*a*b*c^2*f2^2 - a*b*d^2*f1^4 + b^2*c*d*f1^4 + 4*c^3*d*f2^4); % t^4
     gPolynomial(1,4) = (6*a^2*b^2 - 2*a^2*d^2*f1^2 + 2*a^2*d^2*f2^2 + 8*a*b*c*d*f2^2 + 2*b^2*c^2*f1^2 + 2*b^2*c^2*f2^2 + 6*c^2*d^2*f2^4); % t^3
     gPolynomial(1,5) = (- a^2*c*d + 4*a*b^3 + a*b*c^2 - 2*a*b*d^2*f1^2 + 4*a*b*d^2*f2^2 + 2*b^2*c*d*f1^2 + 4*b^2*c*d*f2^2 + 4*c*d^3*f2^4); % t^2
     gPolynomial(1,6) = (- a^2*d^2 + b^4 + b^2*c^2 + 2*b^2*d^2*f2^2 + d^4*f2^4); % t^1
     gPolynomial(1,7) = -b*d*(a*d - b*c); % t^0
     gRoots = roots(gPolynomial);
     
     % Alternative method (slower)
     %g = 't * ((a * t + b)^2 + f2^2 * (c * t + d)^2)^2 - (a * d - b * c) * (1 + f1^2 * t^2)^2 * (a * t + b) * (c * t + d) = 0';
     %gRoots = solve(g, sprintf('f1=%d',f1), sprintf('f2=%d',f2), sprintf('a=%d',a), sprintf('b=%d',b),sprintf('c=%d',c), sprintf('d=%d',d));
     %gRoots = gRoots.t;
    
     % viii
     %s = 't^2 / (1 + f1^2 * t^2) + (c * t + d)^2 / ((a * t + b)^2 + f2^2 * (c * t + d)^2)';
     %sFunction = inline(s);

     tInfinity = 1/f1^2 + c^2/(a^2 + f2^2 * c^2);
     
     gRoots = [gRoots; tInfinity];
     gRoots = double(gRoots);
     
     % Count real zeros
     numRootsReal = 0;
     for j=1:7
         if ( imag(gRoots(j)) == 0 )
            numRootsReal = numRootsReal + 1;
         end;
     end;
     
     % Get real zeros
     gRootsReal = zeros(1,numRootsReal);
     gRootsRealIndex = 1;
     for j=1:7
         if ( imag(gRoots(j)) == 0 )
            gRootsReal(1,gRootsRealIndex) = gRoots(j);
         end;
     end;
     
     % Find tMin
     tMin = [inf,inf];
     for j=1:numRootsReal
         t = double(gRootsReal(j));
         st = t^2 / (1 + f1^2 * t^2) + (c * t + d)^2 / ((a * t + b)^2 + f2^2 * (c * t + d)^2);
         
         if ( st < tMin(2) )
             tMin = [t, st];
         end;
     end;
     t = tMin(1);
     
     % ix
     l1 = [t * f1, 1, -t];
     l2 = [-f2 * (c * t + d), a * t + b, c * t + d]';
     xhat1 = [-l1(1)*l1(3), -l1(2)*l1(3), l1(1)^2 + l1(2)^2];
     xhat2 = [-l2(1)*l2(3), -l2(2)*l2(3), l2(1)^2 + l2(2)^2];

     % x
     xhat1 = T1^-1 * R1' * xhat1';
     xhat2 = T2^-1 * R2' * xhat2';
     
     xhat1 = xhat1 / xhat1(3);
     xhat2 = xhat2 / xhat2(3);
     
     xhats1(:,i) = xhat1;
     xhats2(:,i) = xhat2;
     
    % xi
    A = [xhat1(1) * P1(3,:) - P1(1,:) ;
         xhat1(2) * P1(3,:) - P1(2,:) ;
         xhat2(1) * P2(3,:) - P2(1,:) ;
         xhat2(2) * P2(3,:) - P2(2,:) ];

    A(1,:) = A(1,:)/norm(A(1,:));
    A(2,:) = A(2,:)/norm(A(2,:));
    A(3,:) = A(3,:)/norm(A(3,:));
    A(4,:) = A(4,:)/norm(A(4,:));
    
    [Ua Ea Va] = svd(A);
    X = Va(:,end);
    X = X / X(4);
    
    XList(:,i) = X;
    
    %offset = 800; plot(xhat1(1),xhat1(2),'g.'); plot(xhat2(1)+offset,xhat2(2),'g.');
end;

hold off;

end
