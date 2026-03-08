---
id: cogging_compensation
type: topic
name: Cogging Torque Compensation
level: intermediate
status: unstudied
prerequisites:
  - pmsm_model
  - signal_processing
related:
  - friction_compensation
last_updated: 2026-03-08
---

# Cogging Torque Compensation

## Overview

Cogging torque arises from interaction between permanent magnets and stator slots, causing periodic torque ripple. Compensation techniques aim to generate counteracting torque to smooth motion.

## Methods

- **Lookup table:** Identify cogging torque as a function of rotor position and add an inverse feedforward term.
- **Harmonic injection:** Superimpose appropriate harmonic currents to cancel ripple components.
- **Adaptive control:** Use online estimation to adjust compensation under varying load.

Accurate position sensing and careful identification of cogging profile are essential for effective compensation.