clear; close all; clc;

scriptDir = fileparts(mfilename('fullpath'));
demoRoot = fullfile(scriptDir, '..');
addpath(fullfile(demoRoot, 'functions'));

rng(7);

numInliers = 80;
numOutliers = 30;
trueSlope = 1.8;
trueIntercept = -0.6;
noiseSigma = 0.25;

xIn = linspace(-5, 5, numInliers)';
yIn = trueSlope * xIn + trueIntercept + noiseSigma * randn(numInliers, 1);

xOut = -5 + 10 * rand(numOutliers, 1);
yOut = -8 + 16 * rand(numOutliers, 1);

x = [xIn; xOut];
y = [yIn; yOut];
points = [x, y];

params = struct();
params.maxIterations = 300;
params.threshold = 0.35;
params.minInliers = 20;

[model, inlierMask, stats] = ransacLineFit(points, params);
lsCoeff = polyfit(x, y, 1);

xPlot = linspace(min(x), max(x), 200)';
yTrue = trueSlope * xPlot + trueIntercept;
yRansac = model.slope * xPlot + model.intercept;
yLeastSquares = polyval(lsCoeff, xPlot);

fprintf('True model:      y = %.4f x + %.4f\n', trueSlope, trueIntercept);
fprintf('RANSAC model:    y = %.4f x + %.4f\n', model.slope, model.intercept);
fprintf('Least squares:   y = %.4f x + %.4f\n', lsCoeff(1), lsCoeff(2));
fprintf('RANSAC inliers:  %d / %d\n', nnz(inlierMask), numel(inlierMask));
fprintf('Best iteration:  %d\n', stats.bestIteration);

figure('Color', 'w');
hold on; grid on; box on;
scatter(x(~inlierMask), y(~inlierMask), 36, [0.70 0.70 0.70], 'filled');
scatter(x(inlierMask), y(inlierMask), 42, [0.10 0.45 0.85], 'filled');
plot(xPlot, yTrue, 'k--', 'LineWidth', 1.2);
plot(xPlot, yRansac, 'r-', 'LineWidth', 2.0);
plot(xPlot, yLeastSquares, 'Color', [0.10 0.60 0.25], 'LineWidth', 1.6);
xlabel('x');
ylabel('y');
title('RANSAC Line Fitting Demo');
legend('Outliers', 'RANSAC inliers', 'True line', 'RANSAC fit', 'Least squares', ...
    'Location', 'best');

figureDir = fullfile(demoRoot, 'figures');
if ~exist(figureDir, 'dir')
    mkdir(figureDir);
end
timestamp = datestr(now, 'yyyymmdd_HHMMSS');
saveas(gcf, fullfile(figureDir, ['ransac_line_fit_' timestamp '.png']));

