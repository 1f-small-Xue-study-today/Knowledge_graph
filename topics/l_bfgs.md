---
id: l_bfgs
type: topic
name: Limited-memory BFGS (L-BFGS)
level: intermediate
status: unstudied
prerequisites:
  - numerical_optimization
  - linear_algebra
  - state_space_model
related:
  - numerical_optimization
  - polynomial_optimization
  - robot_trajectory_optimization
last_updated: 2026-07-04
structure:
  language: matlab
  demo_root: demo/l_bfgs
  folders:
    - scripts
    - functions
    - data
    - figures
---

# Limited-memory BFGS (L-BFGS)

## Overview

L-BFGS is a quasi-Newton optimization method that approximates the inverse Hessian with a limited history of gradient/step vectors, enabling memory-efficient optimization for medium and large parameter problems.

## Learning Update (2026-07-04)

- L-BFGS is now tracked as a follow-on method after starting the numerical optimization foundation.

## MATLAB demo goals

- Implement two-loop recursion for search direction.
- Optimize a nonlinear objective (e.g., Rosenbrock).
- Compare convergence vs gradient descent.
- Plot objective and gradient-norm over iterations.
- Track L-BFGS continuation work in `plan/2026/short_term/2026-W19.md`.
