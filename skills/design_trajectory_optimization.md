# Skill: Design Trajectory Optimization Algorithm

## Purpose

Formulate and solve trajectory optimization problems for mobile robots or manipulators subject to dynamics and constraints.

## Inputs

- System dynamics (state transition equations).
- Boundary conditions and waypoint constraints.
- Cost function (e.g., minimize time, energy or smoothness).

## Procedure

1. Choose a parameterization (e.g., polynomials, splines or collocation points).
2. Encode dynamic constraints (state and input bounds) and collision constraints.
3. Define the objective function weighting terms for tracking error, smoothness and control effort.
4. Use numerical optimization techniques (e.g., sequential quadratic programming, convex optimization) to solve for coefficients.
5. Implement warm‑starts and constraint checking to improve convergence.

## Validation

Verify that resulting trajectories satisfy dynamics and constraints; test on simulated or real systems and adjust weights for desired performance.