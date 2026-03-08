---
id: continuous_collision_avoidance
type: topic
name: Continuous Collision Avoidance
level: advanced
status: unstudied
prerequisites:
  - kinodynamic_planning
  - svsdf
related:
  - svsdf
last_updated: 2026-03-08
---

# Continuous Collision Avoidance

## Overview

Continuous collision avoidance ensures that a robot's trajectory avoids obstacles at all times, not just at discrete waypoints. It accounts for swept volumes and dynamic obstacles.

## Methods

- **Trajectory sampling:** Sample the trajectory densely and check collision using distance fields.
- **Convex optimization:** Introduce constraints on velocity and acceleration to keep distance from obstacles positive.
- **Distance field methods:** Use signed distance fields (SDF) or swept volume SDF to compute distances.

Continuous avoidance is crucial for high‑speed platforms and planning under dynamic conditions.