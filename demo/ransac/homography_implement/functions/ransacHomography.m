function [H, bestInlierMask, stats] = ransacHomography(pointMap, varargin)
%RANSACHOMOGRAPHY Estimate a homography using a small custom RANSAC loop.
%
% pointMap is an N-by-4 matrix:
%   [x1, y1, x2, y2]
% where (x1, y1) is a point in image 1 and (x2, y2) is the matched point in
% image 2. The returned H maps image 1 coordinates into image 2 coordinates.

parser = inputParser;
parser.addRequired("pointMap", @(x) isnumeric(x) && size(x, 2) == 4);
parser.addParameter("MaxNumTrials", 1000, @(x) isnumeric(x) && isscalar(x) && x >= 1);
parser.addParameter("StopInlierRatio", 0.6, @(x) isnumeric(x) && isscalar(x) && x > 0 && x <= 1);
parser.addParameter("ReprojectionThreshold", 5, @(x) isnumeric(x) && isscalar(x) && x > 0);
parser.addParameter("Verbose", true, @(x) islogical(x) && isscalar(x));
parser.addParameter("RefineWithInliers", true, @(x) islogical(x) && isscalar(x));
parser.parse(pointMap, varargin{:});
options = parser.Results;

pointMap = double(pointMap);
numMatches = size(pointMap, 1);
if numMatches < 4
    error("ransacHomography:NotEnoughMatches", ...
        "At least 4 matched point pairs are required.");
end

bestH = [];
bestInlierMask = false(numMatches, 1);
bestErrors = inf(numMatches, 1);
lastTrial = 0;

for trial = 1:options.MaxNumTrials
    sampleIdx = randperm(numMatches, 4);
    candidateH = computeHomographyDLT(pointMap(sampleIdx, :));

    if isempty(candidateH) || any(~isfinite(candidateH), "all")
        continue;
    end

    errors = reprojectionErrors(pointMap, candidateH);
    inlierMask = errors < options.ReprojectionThreshold;

    if nnz(inlierMask) > nnz(bestInlierMask)
        bestH = candidateH;
        bestInlierMask = inlierMask;
        bestErrors = errors;
    end

    lastTrial = trial;
    if options.Verbose && (trial == 1 || mod(trial, 50) == 0 || nnz(inlierMask) == nnz(bestInlierMask))
        fprintf("\rRANSAC iteration %d/%d | current inliers: %d | best: %d", ...
            trial, options.MaxNumTrials, nnz(inlierMask), nnz(bestInlierMask));
    end

    if nnz(bestInlierMask) > numMatches * options.StopInlierRatio
        break;
    end
end

if options.Verbose
    fprintf("\n");
end

if isempty(bestH)
    error("ransacHomography:NoModel", ...
        "RANSAC did not find a valid homography.");
end

H = bestH;
if options.RefineWithInliers && nnz(bestInlierMask) >= 4
    refinedH = computeHomographyDLT(pointMap(bestInlierMask, :));
    if ~isempty(refinedH) && all(isfinite(refinedH), "all")
        H = refinedH;
        bestErrors = reprojectionErrors(pointMap, H);
        bestInlierMask = bestErrors < options.ReprojectionThreshold;
    end
end

stats = struct();
stats.numMatches = numMatches;
stats.numInliers = nnz(bestInlierMask);
stats.inlierRatio = stats.numInliers / numMatches;
stats.numTrials = lastTrial;
stats.reprojectionThreshold = options.ReprojectionThreshold;
stats.stopInlierRatio = options.StopInlierRatio;
stats.meanInlierError = mean(bestErrors(bestInlierMask), "omitnan");
stats.medianInlierError = median(bestErrors(bestInlierMask), "omitnan");
end

function H = computeHomographyDLT(pairs)
numPairs = size(pairs, 1);
A = zeros(2 * numPairs, 9);

for k = 1:numPairs
    x1 = pairs(k, 1);
    y1 = pairs(k, 2);
    x2 = pairs(k, 3);
    y2 = pairs(k, 4);

    A(2 * k - 1, :) = [x1, y1, 1, 0, 0, 0, -x2 * x1, -x2 * y1, -x2];
    A(2 * k, :) = [0, 0, 0, x1, y1, 1, -y2 * x1, -y2 * y1, -y2];
end

if rank(A) < 8
    H = [];
    return;
end

[~, ~, V] = svd(A);
h = V(:, end);

H = reshape(h, 3, 3).';

if abs(H(3, 3)) > eps
    H = H / H(3, 3);
else
    H = H / norm(H(:));
end
end

function errors = reprojectionErrors(pointMap, H)
numMatches = size(pointMap, 1);
sourcePoints = [pointMap(:, 1:2), ones(numMatches, 1)].';
projected = H * sourcePoints;

xProjected = projected(1, :) ./ projected(3, :);
yProjected = projected(2, :) ./ projected(3, :);

dx = xProjected.' - pointMap(:, 3);
dy = yProjected.' - pointMap(:, 4);
errors = hypot(dx, dy);
errors(~isfinite(errors)) = inf;
end
