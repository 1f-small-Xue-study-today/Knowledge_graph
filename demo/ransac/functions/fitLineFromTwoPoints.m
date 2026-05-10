function model = fitLineFromTwoPoints(points)
%FITLINEFROMTWOPOINTS Estimate y = ax + b from two distinct 2D points.

dx = points(2, 1) - points(1, 1);
dy = points(2, 2) - points(1, 2);

if abs(dx) < eps
    model = struct('slope', NaN, 'intercept', NaN);
    return;
end

slope = dy / dx;
intercept = points(1, 2) - slope * points(1, 1);
model = struct('slope', slope, 'intercept', intercept);
end

