function [x, history] = gradientDescentOptimize(objective, x0, options)
%GRADIENTDESCENTOPTIMIZE Baseline optimizer for comparison with L-BFGS.

x = x0;
[f, g] = objective(x);

history.x = x.';
history.f = f;
history.gradNorm = norm(g);

for iter = 1:options.maxIterations
    if norm(g) <= options.gradientTolerance
        break;
    end

    direction = -g;
    [xNext, fNext, gNext] = fixedStepWithFallback(objective, x, f, g, direction, options);

    x = xNext;
    f = fNext;
    g = gNext;

    history.x(end + 1, :) = x.';
    history.f(end + 1, 1) = f;
    history.gradNorm(end + 1, 1) = norm(g);
end
end

function [xNext, fNext, gNext] = fixedStepWithFallback(objective, x, f, g, direction, options)
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

