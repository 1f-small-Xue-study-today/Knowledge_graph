---
id: gimbal_disturbance_rejection
type: topic
name: Gimbal Disturbance Rejection
level: intermediate
status: learned
prerequisites:
  - ladrc
  - eso
  - pmsm_model
related:
  - gimbal_control_algorithm_project
last_updated: 2026-05-10
---

# Gimbal Disturbance Rejection

## Overview

Camera gimbals are subject to disturbances such as vibration, wind gusts and coupling between axes. Disturbance rejection techniques maintain stability by estimating and canceling these disturbances.

## Key Ideas

- Use extended state observers to estimate disturbances on each axis.
- Implement LADRC or other robust controllers to counteract disturbances.
- Decouple axes dynamics through feedforward and dynamic compensation.

Careful tuning ensures fast disturbance rejection without amplifying sensor noise.

## Learning Update (2026-05-10)

- Gimbal dynamics and disturbance rejection concepts have been learned.
