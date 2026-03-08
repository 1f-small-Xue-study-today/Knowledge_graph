---
id: svsdf
type: topic
name: Swept Volume Signed Distance Field (SVSDF)
level: advanced
status: unstudied
prerequisites:
  - signal_processing
  - robot_trajectory_optimization
related:
  - continuous_collision_avoidance
last_updated: 2026-03-08
---

# Swept Volume Signed Distance Field (SVSDF)

## Overview

The Swept Volume Signed Distance Field extends the notion of distance fields to account for motion. It represents, for each point in space, the minimum signed distance to the swept volume of a moving body over a time interval.

## Applications

- Continuous collision detection during trajectory optimization.
- Constraint evaluation in kinodynamic planning.
- Real‑time distance computations for dynamic obstacles.

Computing SVSDFs involves discretizing time and space and integrating the robot's shape over its trajectory.