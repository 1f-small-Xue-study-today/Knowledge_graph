---
id: ransac
type: topic
name: RANSAC (Random Sample Consensus)
level: intermediate
status: unstudied
prerequisites:
  - probability
  - linear_algebra
related:
  - modal_identification
  - frf_analysis
last_updated: 2026-05-10
structure:
  language: matlab
  demo_root: demo/ransac
  folders:
    - modal_fit_sweep/scripts
    - modal_fit_sweep/functions
    - modal_fit_sweep/data
    - modal_fit_sweep/figures
    - homography_implement/scripts
    - homography_implement/functions
    - homography_implement/data
    - homography_implement/figures
---

# RANSAC (Random Sample Consensus)

## Overview

RANSAC is a robust estimation method that repeatedly samples minimal subsets, fits a model, and keeps the model with the highest inlier support under a residual threshold.

## Algorithm workflow

![RANSAC algorithm workflow](../algorithm_workflow/ransac_workflow.svg)

## MATLAB demo goals

- Build two MATLAB demos for RANSAC:
  - `demo/ransac/modal_fit_sweep/`: modal-fit demo for sweep data, using user-provided code.
  - `demo/ransac/homography_implement/`: homography re-implementation demo in MATLAB.
- For the modal-fit demo, estimate candidate modal parameters from minimal random samples.
- For the homography demo, estimate candidate projective transforms from minimal point correspondences.
- Use residual thresholding to build robust consensus sets in both demos.
- Refit the final model using all inliers from the best hypothesis.
- Track both demos as this-week plan items in `plan/2026/short_term/2026-W19.md`.
