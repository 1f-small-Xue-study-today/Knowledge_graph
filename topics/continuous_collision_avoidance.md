---
id: continuous_collision_avoidance
type: topic
name: Continuous Collision Avoidance
level: advanced
status: learned
prerequisites:
  - kinodynamic_planning
  - svsdf
related:
  - svsdf
  - implicit_svsdf_planner_front_end
last_updated: 2026-07-04
---

# Continuous Collision Avoidance

## Overview

Continuous collision avoidance ensures that a robot's trajectory avoids obstacles at all times, not just at discrete waypoints. It accounts for swept volumes and dynamic obstacles.

## Methods

- **Trajectory sampling:** Sample the trajectory densely and check collision using distance fields.
- **Convex optimization:** Introduce constraints on velocity and acceleration to keep distance from obstacles positive.
- **Distance field methods:** Use signed distance fields (SDF) or swept volume SDF to compute distances.

Continuous avoidance is crucial for high-speed platforms and planning under dynamic conditions.

## Learning Update (2026-07-04)

- Learned continuous collision avoidance from the Implicit-SVSDF-Planner front-end workflow, especially how swept-volume checks can be embedded into A* successor validation instead of relying only on discrete point collision checks.
