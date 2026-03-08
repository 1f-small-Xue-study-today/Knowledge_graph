---
id: eso
type: topic
name: Extended State Observer
level: intermediate
status: unstudied
prerequisites:
  - state_space_model
  - control_theory
related:
  - ladrc
  - gimbal_disturbance_rejection
last_updated: 2026-03-08
---

# Extended State Observer (ESO)

## Overview

An Extended State Observer augments the state vector with an additional state representing the total disturbance (including model uncertainty). By estimating both the true state and disturbance simultaneously, ESO enables active disturbance rejection.

## Design

Select observer bandwidth \( \omega_o \) high enough to track disturbances but low enough to avoid amplifying noise. Tune gain matrices to ensure stability of the augmented system.

## Importance

ESO forms the core of LADRC, providing real‑time disturbance estimation for robust control.