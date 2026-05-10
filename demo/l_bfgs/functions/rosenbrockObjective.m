function [f, g] = rosenbrockObjective(x)
%ROSENBROCKOBJECTIVE Return value and gradient of the 2D Rosenbrock function.

a = 1;
b = 100;

f = (a - x(1))^2 + b * (x(2) - x(1)^2)^2;

g = zeros(2, 1);
g(1) = -2 * (a - x(1)) - 4 * b * x(1) * (x(2) - x(1)^2);
g(2) = 2 * b * (x(2) - x(1)^2);
end

