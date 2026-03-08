---
id: dead_time_compensation
type: topic
name: Dead-Time Compensation
level: intermediate
status: unstudied
prerequisites:
  - svpwm
  - signal_processing
related:
  - svpwm
last_updated: 2026-03-08
---

# Dead-Time Compensation

## Overview

In power inverters, dead time is inserted between switching transitions to prevent shoot‑through. However, it introduces voltage distortion and torque ripple. Dead‑time compensation corrects the effective duty cycle to mitigate these effects.

## Technique

Calculate voltage error introduced by dead time based on current direction, switching delays, and filter dynamics. Inject compensating voltages or adjust PWM duty cycles accordingly. Accurate current measurement and timing characterization are required.