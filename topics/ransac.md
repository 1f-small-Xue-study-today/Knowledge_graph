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
    - scripts
    - functions
    - data
    - figures
---

# RANSAC (Random Sample Consensus)

## Overview

RANSAC is a robust estimation method that repeatedly samples minimal subsets, fits a model, and keeps the model with the highest inlier support under a residual threshold.

## Algorithm workflow

![RANSAC algorithm workflow](../algorithm_workflow/ransac_workflow.svg)

## MATLAB demo goals

- Generate synthetic data with inliers and outliers.
- Fit a line (or plane) using RANSAC.
- Compare robust fit vs least-squares fit.
- Plot inlier mask and residual distribution.
