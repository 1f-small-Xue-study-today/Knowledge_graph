---
id: svpwm
type: topic
name: Space Vector PWM (SVPWM)
level: intermediate
status: unstudied
prerequisites:
  - foc
related:
  - dead_time_compensation
last_updated: 2026-03-08
---

# Space Vector PWM (SVPWM)

## Overview

SVPWM is a modulation technique for three‑phase inverters that maximizes DC bus utilization and reduces harmonic distortion. It represents the reference voltage vector as a combination of adjacent active and zero vectors.

## Procedure

1. Transform the desired \(v_d, v_q\) references back to phase voltages.
2. Determine sector and compute duty cycles for the two nearest active vectors and zero vector.
3. Update timer compare registers to generate PWM signals.

SVPWM improves efficiency and provides linear modulation range up to 100% of the DC bus voltage.