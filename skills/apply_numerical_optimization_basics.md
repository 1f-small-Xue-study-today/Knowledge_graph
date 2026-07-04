# Skill: Apply Numerical Optimization Basics

## Purpose

Formulate and solve starter numerical optimization problems for control, robotics, model identification, and design workflows.

## Inputs

- Decision variables and initial guess.
- Objective function and, when available, analytical or numerical gradients.
- Equality or inequality constraints.
- Scaling, tolerance, iteration limit, and line-search or trust-region settings.
- Validation data or expected physical behavior.

## Procedure

1. Define the decision variables, objective function, constraints, and expected units.
2. Normalize or scale variables so the optimizer is not dominated by poorly conditioned terms.
3. Choose a starter method such as gradient descent, Gauss-Newton, Newton, L-BFGS, or constrained penalty/barrier formulation.
4. Compute or verify gradients using finite differences before trusting convergence.
5. Select step-size, line-search, tolerance, and stopping rules.
6. Run optimization from multiple initial guesses when the problem is nonconvex.
7. Validate the result against physical constraints, residuals, held-out data, or simulation.

## Validation

- Check objective decrease, gradient norm, constraint violation, and parameter plausibility.
- Compare analytical gradients against finite-difference gradients.
- Inspect sensitivity to scaling, initialization, noise, and solver settings.
- Confirm that the optimized result improves the real control, planning, identification, or design task.
