---
id: l_bfgs
type: topic
name: Limited-memory BFGS (L-BFGS)
level: intermediate
status: unstudied
prerequisites:
  - optimal_control
  - linear_algebra
  - state_space_model
related:
  - polynomial_optimization
  - robot_trajectory_optimization
last_updated: 2026-05-10
structure:
  language: matlab
  demo_root: demos/l_bfgs
  folders:
    - scripts
    - functions
    - data
    - figures
---

# Limited-memory BFGS (L-BFGS)

## Overview

L-BFGS is a quasi-Newton optimization method that approximates the inverse Hessian with a limited history of gradient/step vectors, enabling memory-efficient optimization for medium and large parameter problems.

## MATLAB demo goals

- Implement two-loop recursion for search direction.
- Optimize a nonlinear objective (e.g., Rosenbrock).
- Compare convergence vs gradient descent.
- Plot objective and gradient-norm over iterations.
