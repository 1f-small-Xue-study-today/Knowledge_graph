---
id: ladrc
type: topic
name: Linear Active Disturbance Rejection Control
level: intermediate
status: unstudied
prerequisites:
  - control_theory
  - state_space_model
  - pmsm_model
related:
  - eso
  - pid_control
  - gimbal_disturbance_rejection
last_updated: 2026-03-08
---

# Linear Active Disturbance Rejection Control (LADRC)

## Overview

LADRC is a robust control strategy that estimates and compensates for unknown disturbances and model uncertainties in real time. It combines a tracking differentiator, an extended state observer and a simple feedback law.

## Elements

- **Tracking differentiator:** Generates smooth reference trajectories and their derivatives.
- **Extended state observer (ESO):** Estimates system states and total disturbances.
- **Control law:** Cancels disturbances and imposes desired dynamics via a simple PI or PD structure.

## Applications

LADRC is widely used in motor control and gimbal systems because it can reject load disturbances, friction and cogging torque without precise modeling.