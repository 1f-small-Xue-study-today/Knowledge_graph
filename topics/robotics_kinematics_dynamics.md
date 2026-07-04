---
id: robotics_kinematics_dynamics
type: topic
name: Robotics Kinematics and Dynamics
level: advanced
status: learned
prerequisites:
  - linear_algebra
  - state_space_model
  - control_theory
related:
  - robot_trajectory_optimization
  - kinodynamic_planning
  - gimbal_disturbance_rejection
  - fusion360_uav_mechanical_design
last_updated: 2026-07-04
---

# Robotics Kinematics and Dynamics

## Overview

Robotics kinematics and dynamics describe how robot states, coordinate frames, velocities, forces, and torques transform through a mechanism. This knowledge supports robot planning, gimbal control, motor control, and model-based debugging.

## Strengths

- State and frame transformations using rotation matrices, quaternions, homogeneous transforms, SE(3), and SO(3).
- Forward and inverse kinematics for mapping joint states to task-space pose.
- Jacobian derivation for velocity mapping, force/torque mapping, singularity analysis, and differential motion.
- Rigid-body dynamics using Newton-Euler or Lagrange formulations.
- Model structure such as mass matrix, Coriolis/centrifugal terms, gravity terms, damping, friction, and external wrench mapping.
- Applying state-space models to robot motion, control, planning, and observer design.

## Applications

- Convert between body, world, motor, sensor, and task frames.
- Build Jacobians for trajectory optimization, control allocation, and constraint gradients.
- Derive dynamic constraints for kinodynamic planning and model predictive control.
- Analyze coupling between motor dynamics, mechanical load, and robot/gimbal motion.
- Debug robotics systems by checking signs, frames, units, and physical consistency.
- Connect CAD/mechanical design decisions to control behavior through mass distribution, stiffness, vibration, resonance, and sensor placement.

## Learning Update (2026-07-04)

- Strong robotics foundation recorded: state transforms, Jacobians, kinematics, dynamics, and model-based reasoning.
- Strong Fusion 360 UAV mechanical design capability is also recorded as a related hardware-design strength.
