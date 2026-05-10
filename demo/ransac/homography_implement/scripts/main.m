clear;
clc;

scriptDir = fileparts(mfilename("fullpath"));
projectDir = fileparts(scriptDir);
dataDir = fullfile(projectDir, "data");
functionsDir = fullfile(projectDir, "functions");
timestamp = string(datetime("now", "Format", "yyyy-MM-dd-HHmmss"));
outputDir = fullfile(projectDir, "figures", timestamp);

addpath(functionsDir);
if ~exist(outputDir, "dir")
    mkdir(outputDir);
end

config = struct();
config.maxFeatures = 5000;
config.maxDisplayedMatches = 1000;
config.maxNumTrials = 1000;
config.stopInlierRatio = 0.6;
config.reprojectionThreshold = 12;
config.randomSeed = 7;
config.maxPanoramaPixels = 70000000;
config.warpBlockRows = 256;

rng(config.randomSeed);

image1 = imread(fullfile(dataDir, "1.png"));
image2 = imread(fullfile(dataDir, "2.png"));
gray1 = toGray(image1);
gray2 = toGray(image2);

fprintf("Creating point map from SIFT matches...\n");
[pointMap, matchedPoints1, matchedPoints2, keypoints1, keypoints2] = ...
    createPointMap(gray1, gray2, config);

writetable(array2table(pointMap, ...
    "VariableNames", ["x1", "y1", "x2", "y2"]), ...
    fullfile(outputDir, "point_map.csv"));

imwrite(drawKeypointsImage(image1, keypoints1, config.maxDisplayedMatches), ...
    fullfile(outputDir, "keypoints-1.png"));
imwrite(drawKeypointsImage(image2, keypoints2, config.maxDisplayedMatches), ...
    fullfile(outputDir, "keypoints-2.png"));
imwrite(drawMatchesImage(image1, image2, pointMap, [], config.maxDisplayedMatches), ...
    fullfile(outputDir, "matches.png"));

fprintf("Running custom RANSAC homography...\n");
[H, inlierMask, stats] = ransacHomography(pointMap, ...
    "MaxNumTrials", config.maxNumTrials, ...
    "StopInlierRatio", config.stopInlierRatio, ...
    "ReprojectionThreshold", config.reprojectionThreshold, ...
    "Verbose", true);

imwrite(drawMatchesImage(image1, image2, pointMap, inlierMask, config.maxDisplayedMatches), ...
    fullfile(outputDir, "inlier_matches.png"));

fprintf("Creating stitched image...\n");
stitchedImage = stitchImages(image1, image2, H, config);
imwrite(stitchedImage, fullfile(outputDir, "stitched.png"));

writeInfo(fullfile(outputDir, "info.txt"), H, stats);

fprintf("Done.\n");
fprintf("Output folder:\n%s\n", outputDir);
fprintf("Inliers: %d/%d (%.2f%%)\n", stats.numInliers, stats.numMatches, 100 * stats.inlierRatio);

function [pointMap, matchedPoints1, matchedPoints2, keypoints1, keypoints2] = createPointMap(gray1, gray2, config)
keypoints1 = detectSIFTFeatures(gray1);
keypoints2 = detectSIFTFeatures(gray2);

keypoints1 = selectStrongest(keypoints1, min(config.maxFeatures, keypoints1.Count));
keypoints2 = selectStrongest(keypoints2, min(config.maxFeatures, keypoints2.Count));

[features1, validPoints1] = extractFeatures(gray1, keypoints1);
[features2, validPoints2] = extractFeatures(gray2, keypoints2);

indexPairs = matchFeatures(features1, features2, ...
    "Unique", true, ...
    "MaxRatio", 0.8);

matchedPoints1 = validPoints1(indexPairs(:, 1));
matchedPoints2 = validPoints2(indexPairs(:, 2));

pointMap = [matchedPoints1.Location, matchedPoints2.Location];
if size(pointMap, 1) < 4
    error("main:NotEnoughMatches", ...
        "Only %d matches were found; at least 4 are required.", size(pointMap, 1));
end
end

function gray = toGray(image)
if size(image, 3) == 3
    gray = im2gray(image);
else
    gray = image;
end
end

function rgb = toRgb(image)
if size(image, 3) == 1
    rgb = repmat(image, 1, 1, 3);
else
    rgb = image;
end

if ~isa(rgb, "uint8")
    rgb = im2uint8(rgb);
end
end

function output = drawKeypointsImage(image, points, maxPoints)
output = toRgb(image);
locations = points.Location;
if size(locations, 1) > maxPoints
    locations = locations(1:maxPoints, :);
end

if ~isempty(locations)
    output = insertMarker(output, locations, "o", ...
        "Color", "yellow", ...
        "Size", 4);
end
end

function output = drawMatchesImage(image1, image2, pointMap, inlierMask, maxPoints)
rgb1 = toRgb(image1);
rgb2 = toRgb(image2);

[height1, width1, ~] = size(rgb1);
[height2, width2, ~] = size(rgb2);
output = zeros(max(height1, height2), width1 + width2, 3, "uint8");
output(1:height1, 1:width1, :) = rgb1;
output(1:height2, width1 + (1:width2), :) = rgb2;

numMatches = size(pointMap, 1);
sampleIdx = randperm(numMatches, min(numMatches, maxPoints));
sample = pointMap(sampleIdx, :);
lines = [sample(:, 1), sample(:, 2), sample(:, 3) + width1, sample(:, 4)];

if isempty(inlierMask)
    output = insertShape(output, "Line", lines, ...
        "Color", "blue", ...
        "LineWidth", 1);
else
    sampledInliers = inlierMask(sampleIdx);
    if any(sampledInliers)
        output = insertShape(output, "Line", lines(sampledInliers, :), ...
            "Color", "green", ...
            "LineWidth", 1);
    end
    if any(~sampledInliers)
        output = insertShape(output, "Line", lines(~sampledInliers, :), ...
            "Color", "red", ...
            "LineWidth", 1);
    end
end

markers = [sample(:, 1:2); sample(:, 3) + width1, sample(:, 4)];
output = insertMarker(output, markers, "o", ...
    "Color", "blue", ...
    "Size", 4);
end

function panorama = stitchImages(image1, image2, H, config)
rgb1 = toRgb(image1);
rgb2 = toRgb(image2);

[height1, width1, ~] = size(rgb1);
[height2, width2, ~] = size(rgb2);

corners1 = [1, 1; width1, 1; width1, height1; 1, height1];
corners2 = [1, 1; width2, 1; width2, height2; 1, height2];
warpedCorners1 = transformPoints(H, corners1);
allCorners = [warpedCorners1; corners2];

xMin = floor(min(allCorners(:, 1)));
xMax = ceil(max(allCorners(:, 1)));
yMin = floor(min(allCorners(:, 2)));
yMax = ceil(max(allCorners(:, 2)));

outWidth = xMax - xMin + 1;
outHeight = yMax - yMin + 1;
if outWidth * outHeight > config.maxPanoramaPixels
    error("main:PanoramaTooLarge", ...
        "Panorama canvas would be %d-by-%d. Check the homography or raise maxPanoramaPixels.", ...
        outWidth, outHeight);
end

shiftX = 1 - xMin;
shiftY = 1 - yMin;

accum = zeros(outHeight, outWidth, 3, "single");
weight = zeros(outHeight, outWidth, "single");

image2Rows = (1:height2) + shiftY;
image2Cols = (1:width2) + shiftX;
for channel = 1:3
    accum(image2Rows, image2Cols, channel) = single(rgb2(:, :, channel));
end
weight(image2Rows, image2Cols) = 1;

rgb1Single = single(rgb1);

for rowStart = 1:config.warpBlockRows:outHeight
    rowEnd = min(rowStart + config.warpBlockRows - 1, outHeight);
    rowRange = rowStart:rowEnd;

    [xOutput, yOutput] = meshgrid((1:outWidth) - shiftX, rowRange - shiftY);
    source = H \ [xOutput(:).'; yOutput(:).'; ones(1, numel(xOutput))];
    xSource = source(1, :) ./ source(3, :);
    ySource = source(2, :) ./ source(3, :);

    valid = isfinite(xSource) & isfinite(ySource) & ...
        xSource >= 1 & xSource <= width1 & ...
        ySource >= 1 & ySource <= height1;

    if ~any(valid)
        continue;
    end

    validLinear = find(valid).';
    xValid = xSource(valid);
    yValid = ySource(valid);

    for channel = 1:3
        block = accum(rowRange, :, channel);
        values = interp2(rgb1Single(:, :, channel), xValid, yValid, "linear", 0);
        block(validLinear) = block(validLinear) + values(:);
        accum(rowRange, :, channel) = block;
    end

    weightBlock = weight(rowRange, :);
    weightBlock(validLinear) = weightBlock(validLinear) + 1;
    weight(rowRange, :) = weightBlock;
end

panorama = zeros(outHeight, outWidth, 3, "uint8");
hasPixel = weight > 0;
for channel = 1:3
    channelData = zeros(outHeight, outWidth, "uint8");
    blended = accum(:, :, channel) ./ max(weight, 1);
    channelData(hasPixel) = uint8(min(max(blended(hasPixel), 0), 255));
    panorama(:, :, channel) = channelData;
end
end

function pointsOut = transformPoints(H, pointsIn)
homogeneousPoints = [pointsIn, ones(size(pointsIn, 1), 1)].';
projected = H * homogeneousPoints;
pointsOut = [projected(1, :) ./ projected(3, :); ...
    projected(2, :) ./ projected(3, :)].';
end

function writeInfo(filePath, H, stats)
fid = fopen(filePath, "w");
cleanup = onCleanup(@() fclose(fid));

fprintf(fid, "Homography maps image 1 coordinates into image 2 coordinates.\n\n");
fprintf(fid, "H =\n");
fprintf(fid, "%.12g %.12g %.12g\n", H.');
fprintf(fid, "\n");
fprintf(fid, "Num matches: %d\n", stats.numMatches);
fprintf(fid, "Num inliers: %d\n", stats.numInliers);
fprintf(fid, "Inlier ratio: %.6f\n", stats.inlierRatio);
fprintf(fid, "RANSAC trials: %d\n", stats.numTrials);
fprintf(fid, "Reprojection threshold: %.6f pixels\n", stats.reprojectionThreshold);
fprintf(fid, "Mean inlier error: %.6f pixels\n", stats.meanInlierError);
fprintf(fid, "Median inlier error: %.6f pixels\n", stats.medianInlierError);
end
