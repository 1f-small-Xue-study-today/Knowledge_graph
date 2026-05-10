# Skill: Implement RANSAC Demo in MATLAB

## Purpose

Build a robust model-fitting demo in MATLAB that can tolerate outliers and quantify inlier quality.

## Inputs

- Dataset (synthetic or recorded) with outliers.
- Model type (line/plane/polynomial) and minimal sample size.
- Inlier threshold and iteration budget.

## Procedure

1. Randomly sample minimal subsets and estimate model parameters.
2. Compute residuals for all samples and classify inliers.
3. Keep the model with the largest consensus set (or best inlier score).
4. Refit with all inliers for final parameters.
5. Visualize inlier/outlier separation and fitting quality.

## Validation

Evaluate inlier ratio, parameter error against ground truth, and repeatability across random seeds.
