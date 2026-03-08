# Skill: Implement Kinodynamic Planner

## Purpose

Develop a planner that accounts for both kinematic and dynamic constraints while exploring the state space.

## Inputs

- Robot dynamics model.
- Configuration space and obstacle information.
- Initial and goal states.

## Procedure

1. Select a kinodynamic planning algorithm (e.g., RRT, RRT*, kinodynamic A*).
2. Define control primitives or integration steps and integrate the dynamics to generate motion segments.
3. Implement collision checking for each segment using distance fields or SDFs.
4. Incorporate cost metrics (e.g., path length, energy) and heuristics.
5. Refine the path with trajectory optimization techniques to improve smoothness.

## Validation

Test the planner in simulation and on hardware; ensure feasible paths are found within reasonable time and satisfy dynamic constraints.