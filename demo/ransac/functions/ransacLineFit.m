function [bestModel, bestInlierMask, stats] = ransacLineFit(points, params)
%RANSACLINEFIT Robustly fit a 2D line y = ax + b with RANSAC.

if nargin < 2
    params = struct();
end

params = setDefault(params, 'maxIterations', 200);
params = setDefault(params, 'threshold', 0.25);
params = setDefault(params, 'minInliers', 2);

if size(points, 2) ~= 2
    error('ransacLineFit:InvalidPoints', 'Points must be an N-by-2 matrix.');
end
if params.maxIterations <= 0 || params.threshold <= 0 || params.minInliers < 0
    error('ransacLineFit:InvalidParams', 'Invalid RANSAC parameter values.');
end

numPoints = size(points, 1);
bestInlierMask = false(numPoints, 1);
bestScore = inf;
bestModel = struct('slope', NaN, 'intercept', NaN);
bestIteration = 0;

if numPoints < 2
    error('ransacLineFit:NotEnoughPoints', 'At least two points are required.');
end

for iter = 1:params.maxIterations
    sampleIdx = randperm(numPoints, 2);
    candidate = fitLineFromTwoPoints(points(sampleIdx, :));

    if ~isfinite(candidate.slope) || ~isfinite(candidate.intercept)
        continue;
    end

    residuals = abs(points(:, 2) - (candidate.slope * points(:, 1) + candidate.intercept));
    inlierMask = residuals <= params.threshold;
    inlierCount = nnz(inlierMask);

    if inlierCount < params.minInliers
        continue;
    end

    score = mean(residuals(inlierMask));
    isBetter = inlierCount > nnz(bestInlierMask) || ...
        (inlierCount == nnz(bestInlierMask) && score < bestScore);

    if isBetter
        bestInlierMask = inlierMask;
        bestScore = score;
        bestModel = candidate;
        bestIteration = iter;
    end
end

if nnz(bestInlierMask) >= 2
    coeff = polyfit(points(bestInlierMask, 1), points(bestInlierMask, 2), 1);
    bestModel.slope = coeff(1);
    bestModel.intercept = coeff(2);
else
    warning('ransacLineFit:NoConsensus', 'No valid consensus set found; using least squares.');
    coeff = polyfit(points(:, 1), points(:, 2), 1);
    bestModel.slope = coeff(1);
    bestModel.intercept = coeff(2);
    residuals = abs(points(:, 2) - polyval(coeff, points(:, 1)));
    bestInlierMask = residuals <= params.threshold;
end

stats = struct();
stats.bestIteration = bestIteration;
stats.inlierCount = nnz(bestInlierMask);
stats.inlierRatio = stats.inlierCount / numPoints;
stats.meanInlierResidual = bestScore;
end

function params = setDefault(params, fieldName, value)
if ~isfield(params, fieldName) || isempty(params.(fieldName))
    params.(fieldName) = value;
end
end
