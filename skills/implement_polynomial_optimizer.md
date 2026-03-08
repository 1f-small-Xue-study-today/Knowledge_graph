# Skill: Implement Polynomial Trajectory Optimizer

## Purpose

Implement an algorithm that generates smooth polynomial trajectories subject to boundary conditions, continuity and dynamic limits.

## Inputs

- Waypoints or boundary conditions (positions, velocities, accelerations).
- Segment durations and polynomial order.
- Cost function weights.

## Procedure

1. Formulate the polynomial coefficients as decision variables.
2. Construct equality constraints to satisfy boundary conditions and continuity across segments.
3. Build a cost function penalizing high‑order derivatives (e.g., jerk or snap).
4. Solve the resulting linear system or quadratic program analytically or numerically.
5. Output coefficients and evaluate trajectories for real‑time implementation.

## Validation

Test the optimizer on typical flight or motion tasks; verify continuity and smoothness; compare against existing algorithms (e.g., MINCO).