function [x, history] = lbfgsOptimize(objective, x0, options)
%LBFGSOPTIMIZE Minimize a smooth function with limited-memory BFGS.

if nargin < 3
    options = struct();
end

options = setDefault(options, 'maxIterations', 100);
options = setDefault(options, 'gradientTolerance', 1e-6);
options = setDefault(options, 'historySize', 8);
options = setDefault(options, 'initialStep', 1.0);
options = setDefault(options, 'armijo', 1e-4);
options = setDefault(options, 'backtrack', 0.5);

if options.maxIterations <= 0 || options.gradientTolerance <= 0 || ...
        options.historySize <= 0 || options.initialStep <= 0 || ...
        options.armijo <= 0 || options.backtrack <= 0 || options.backtrack >= 1
    error('lbfgsOptimize:InvalidOptions', 'Invalid L-BFGS option values.');
end

x = x0;
[f, g] = objective(x);
sHistory = {};
yHistory = {};
rhoHistory = [];

history.x = x.';
history.f = f;
history.gradNorm = norm(g);

for iter = 1:options.maxIterations
    if norm(g) <= options.gradientTolerance
        break;
    end

    direction = twoLoopRecursion(g, sHistory, yHistory, rhoHistory);
    if g.' * direction >= 0
        direction = -g;
    end

    [xNext, fNext, gNext] = backtrackingLineSearch(objective, x, f, g, direction, options);

    s = xNext - x;
    y = gNext - g;
    curvature = y.' * s;

    if curvature > 1e-12
        if numel(sHistory) == options.historySize
            sHistory(1) = [];
            yHistory(1) = [];
            rhoHistory(1) = [];
        end
        sHistory{end + 1} = s;
        yHistory{end + 1} = y;
        rhoHistory(end + 1) = 1 / curvature;
    end

    x = xNext;
    f = fNext;
    g = gNext;

    history.x(end + 1, :) = x.';
    history.f(end + 1, 1) = f;
    history.gradNorm(end + 1, 1) = norm(g);
end
end

function options = setDefault(options, fieldName, value)
if ~isfield(options, fieldName) || isempty(options.(fieldName))
    options.(fieldName) = value;
end
end

function direction = twoLoopRecursion(g, sHistory, yHistory, rhoHistory)
q = g;
numPairs = numel(sHistory);
alpha = zeros(numPairs, 1);

for i = numPairs:-1:1
    alpha(i) = rhoHistory(i) * (sHistory{i}.' * q);
    q = q - alpha(i) * yHistory{i};
end

if numPairs > 0
    sLast = sHistory{end};
    yLast = yHistory{end};
    gamma = (sLast.' * yLast) / (yLast.' * yLast);
else
    gamma = 1;
end

r = gamma * q;

for i = 1:numPairs
    beta = rhoHistory(i) * (yHistory{i}.' * r);
    r = r + sHistory{i} * (alpha(i) - beta);
end

direction = -r;
end

function [xNext, fNext, gNext] = backtrackingLineSearch(objective, x, f, g, direction, options)
step = options.initialStep;
slope = g.' * direction;

while true
    xNext = x + step * direction;
    [fNext, gNext] = objective(xNext);

    if fNext <= f + options.armijo * step * slope
        return;
    end

    step = step * options.backtrack;
    if step < 1e-12
        xNext = x;
        fNext = f;
        gNext = g;
        return;
    end
end
end
