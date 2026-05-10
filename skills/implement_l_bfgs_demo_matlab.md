# Skill: Implement L-BFGS Demo in MATLAB

## Purpose

Implement and test an L-BFGS optimizer in MATLAB for smooth nonlinear objectives.

## Inputs

- Objective function handle and gradient function handle.
- Initial parameter vector and stopping criteria.
- History size `m`, line-search settings, max iterations.

## Procedure

1. Initialize parameters and empty history buffers.
2. Compute L-BFGS search direction with two-loop recursion.
3. Perform line search (e.g., backtracking/Wolfe-style).
4. Update state and history pairs `(s_k, y_k)`.
5. Track objective value and gradient norm across iterations.

## Validation

Confirm monotonic objective decrease in typical cases, gradient-norm reduction, and convergence speed vs gradient descent.
