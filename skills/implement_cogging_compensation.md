# Skill: Implement Cogging Compensation

## Purpose

Reduce periodic torque ripple in PMSM or gimbal systems by compensating cogging torque.

## Inputs

- Identified cogging torque profile as a function of rotor angle.
- Real‑time rotor position (from hall sensors, encoder or observer).

## Procedure

1. Perform system identification: fix the rotor or operate at low speed and measure torque ripple versus angle.
2. Create a cogging torque lookup table or harmonic series representation.
3. Implement feedforward compensation by adding a counteracting torque command proportional to the cogging profile.
4. Update compensation table as parameters vary (e.g., with temperature or load).
5. Optionally combine with LADRC or observers for adaptive compensation.

## Validation

Monitor motor current and torque ripple before and after compensation to ensure ripple amplitude decreases significantly.