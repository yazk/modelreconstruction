function [pLeft, pRight] = myRANSAC( pLeft, pRight )
%[best_model, best_consensus_set, best_error]
% input:
%     data - a set of observations
%     model - a model that can be fitted to data 
%     n - the minimum number of data required to fit the model
%     k - the number of iterations performed by the algorithm
%     t - a threshold value for determining when a datum fits a model
%     d - the number of close data values required to assert that a model fits well to data
% output:
%     best_model - model parameters which best fit the data (or nil if no good model is found)
%     best_consensus_set - data point from which this model has been estimated
%     best_error - the error of this model relative to the data 

% data = [pLeft;pRight]
% model = F, the fundamental matrix
% n = 8 (for Eight Point Algorithm)
% k = 1000 iterations
% t = 0.1 threshold
% d = 8

dataOriginal = [pLeft;pRight];
n = 8;
k = 2000;
t = 0.02;
d = size(pLeft,2) * 0.50; %8

iterations = 0;
best_model = 0;
best_consensus_set = 0;
best_error = inf;

while ( iterations < k )
    data = dataOriginal;
    numPts = size(data,2);
    
    % maybe_inliers := n randomly selected values from data
    maybe_inliers = zeros(6,n);
    for i=1:n
        index = randi(numPts,1); % randomly pick a set of points
        maybe_inliers(:,i) = data(:,index); % add to maybe_inliers set
        data(:,index) = []; % remove from data set
        numPts = numPts - 1; % number of points is one less
    end;
    
    % maybe_model := model parameters fitted to maybe_inliers
    maybe_model = NormalizedEightPointAlgorithm(maybe_inliers(1:3,:),maybe_inliers(4:6,:));
    
    % consensus_set := maybe_inliers
    consensus_set = maybe_inliers;
    
    % for every point in data not in maybe_inliers 
    i = 1;
    while ( i < numPts )
        error = computeError( data(1:3,i), data(4:6,i), maybe_model );
        
        % if point fits maybe_model with an error smaller than t
        if ( error < t )
            % add point to consensus_set
            consensus_set = cat(2, consensus_set, data(:,i));
            data(:,i) = [];
            numPts = numPts - 1;
            i = i - 1;
        end
        
        i = i + 1;
    end
    
    % if the number of elements in consensus_set is > d 
    % (this implies that we may have found a good model, now test how good it is)
    if ( size(consensus_set,2) > d  && size(data,2) > 8 ) % size(data,2) = num pts in data
        % better_model := model parameters fitted to all points in consensus_set
        better_model = NormalizedEightPointAlgorithm(data(1:3,:),data(4:6,:));
        
        % this_error := a measure of how well better_model fits these points
        this_error = computeError( data(1:3,:), data(4:6,:), better_model );

        % if this_error < best_error
        % (we have found a model which is better than any of the previous
        % ones, keep it until a better one is found)
        if ( this_error < best_error )
            % best_model := better_model
            best_model = better_model;
            
            % best_consensus_set := consensus_set
            best_consensus_set = consensus_set;
            
            % best_error := this_error
            best_error = this_error;
        end
    end

    iterations = iterations + 1;
end;

F = best_model;
best_error
imagePairs = size(best_consensus_set,2)
if ( size(best_consensus_set,2) > 8 )
    pLeft = best_consensus_set(1:3,:);
    pRight = best_consensus_set(4:6,:);
end;
