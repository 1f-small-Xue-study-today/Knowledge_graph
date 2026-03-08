# Skill: Implement Continuous Collision Avoidance

## Purpose

Ensure that robot trajectories remain collision‑free over continuous time by enforcing constraints derived from distance fields.

## Inputs

- Planned trajectory and its derivatives.
- Distance field or SVSDF for the environment.
- Safety margin.

## Procedure

1. Evaluate distances along the trajectory using an SDF or SVSDF at a sufficient temporal resolution.
2. Identify intervals where distance approaches zero; compute gradients or sensitivity.
3. Modify the trajectory via optimization to maintain a positive distance margin.
4. Incorporate constraints into trajectory generation or planning to avoid dynamic obstacles.

## Validation

Simulate the trajectory in environments with static and moving obstacles; verify that collisions do not occur between sampling points.