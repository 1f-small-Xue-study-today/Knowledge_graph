---
id: polynomial_optimization
type: topic
name: Polynomial Trajectory Optimization
level: intermediate
status: unstudied
prerequisites:
  - optimal_control
  - linear_algebra
related:
  - robot_trajectory_optimization
last_updated: 2026-03-08
---

# Polynomial Trajectory Optimization

## Overview

Polynomial trajectory optimization (e.g., MINCO, minimum snap) parameterizes trajectories using piecewise polynomials and optimizes coefficients to minimize high‑order derivatives subject to boundary conditions and waypoints.

## Key Concepts

- **Splines and Bézier curves:** Represent trajectory segments.
- **Cost functions:** Penalize jerk, snap or other smoothness measures.
- **Constraint enforcement:** Ensure continuity and satisfy dynamic limits.

Polynomial methods yield closed‑form solutions and efficient planning for quadrotors and manipulators.