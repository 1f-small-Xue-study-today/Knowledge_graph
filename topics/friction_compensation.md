---
id: friction_compensation
type: topic
name: Friction Compensation
level: intermediate
status: unstudied
prerequisites:
  - pmsm_model
  - signal_processing
related:
  - cogging_compensation
last_updated: 2026-03-08
---

# Friction Compensation

## Overview

Friction introduces nonlinear resistance that impairs control performance. It includes static (Coulomb) friction, viscous damping and Stribeck effects. Compensation aims to improve tracking and reduce steady‑state error.

## Approach

- Model friction as a combination of Coulomb, viscous and Stribeck terms.
- Estimate parameters via experiments (e.g., torque vs. speed tests).
- Implement feedforward or disturbance observer‑based compensation to counteract friction forces.

In gimbal systems, accurate friction compensation is critical for smooth low‑speed motion.