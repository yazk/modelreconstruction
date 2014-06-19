function [ F ] = NormalizedEightPointAlgorithm( pLeft, pRight )
% Algorithm 5.1 (The eight-point algorithm for the fundamental matrix).
% Yi Ma - p. 212

if ( size(pLeft,2) < 8 || size(pRight,2) < 8 )
    disp('Error, less than 8 points were given!');
    return;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Normalize
[normLeft, normRight] = getNormalization(pLeft, pRight);
%[pLeft, pRight] = PointNormalization(pLeft, pRight, normLeft, normRight);
pLeft = normLeft * pLeft;
pRight = normRight * pRight;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Step 1: Compute a first approximation of the fundamental matrix
numPoints = size(pLeft,2);

X = zeros(9,numPoints);

for i=1:numPoints
    pLeftPt = pLeft(:,i);
    pRightPt = pRight(:,i);
    
    A_i = kron(pLeftPt, pRightPt);
    X(:,i) = A_i;
end;

X = X';
[UX, EX, VX] = svd(X);

ES = VX(:,end);

F = reshape(ES, 3,3);

% Step 2: Impose the rank constraint and recover the fundamental matrix
[UF, EF, VF] = svd(F);

F = UF*[EF(1,1) 0 0; 0 EF(2,2) 0; 0 0 0]*VF';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% De-normalize
%[pLeft, pRight] = PointDeNormalization(pLeft, pRight, normLeft, normRight);
%pLeft = normLeft^-1 * pLeft; % not required
%pRight = normRight^-1 * pRight; % not required
F = normRight' * F * normLeft;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%