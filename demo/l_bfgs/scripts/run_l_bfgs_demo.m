clear; close all; clc;

scriptDir = fileparts(mfilename('fullpath'));
demoRoot = fullfile(scriptDir, '..');
addpath(fullfile(demoRoot, 'functions'));

x0 = [-1.2; 1.0];

options = struct();
options.maxIterations = 800;
options.gradientTolerance = 1e-6;
options.historySize = 8;
options.initialStep = 1.0;
options.armijo = 1e-4;
options.backtrack = 0.5;

[xLbfgs, historyLbfgs] = lbfgsOptimize(@rosenbrockObjective, x0, options);

gdOptions = options;
gdOptions.initialStep = 1e-3;
[xGradient, historyGradient] = gradientDescentOptimize(@rosenbrockObjective, x0, gdOptions);

fprintf('L-BFGS solution:          x = [%.8f, %.8f], f = %.8e, iterations = %d\n', ...
    xLbfgs(1), xLbfgs(2), historyLbfgs.f(end), numel(historyLbfgs.f) - 1);
fprintf('Gradient descent result:  x = [%.8f, %.8f], f = %.8e, iterations = %d\n', ...
    xGradient(1), xGradient(2), historyGradient.f(end), numel(historyGradient.f) - 1);

figure('Color', 'w');
tiledlayout(1, 2);

nexttile;
semilogy(0:numel(historyLbfgs.f)-1, historyLbfgs.f, 'r-', 'LineWidth', 1.8);
hold on; grid on; box on;
semilogy(0:numel(historyGradient.f)-1, historyGradient.f, 'Color', [0.10 0.45 0.85], ...
    'LineWidth', 1.5);
xlabel('Iteration');
ylabel('Objective');
title('Objective Convergence');
legend('L-BFGS', 'Gradient descent', 'Location', 'best');

nexttile;
semilogy(0:numel(historyLbfgs.gradNorm)-1, historyLbfgs.gradNorm, 'r-', 'LineWidth', 1.8);
hold on; grid on; box on;
semilogy(0:numel(historyGradient.gradNorm)-1, historyGradient.gradNorm, ...
    'Color', [0.10 0.45 0.85], 'LineWidth', 1.5);
xlabel('Iteration');
ylabel('Gradient norm');
title('Gradient Norm');
legend('L-BFGS', 'Gradient descent', 'Location', 'best');

figureDir = fullfile(demoRoot, 'figures');
if ~exist(figureDir, 'dir')
    mkdir(figureDir);
end
timestamp = datestr(now, 'yyyymmdd_HHMMSS');
saveas(gcf, fullfile(figureDir, ['l_bfgs_convergence_' timestamp '.png']));
