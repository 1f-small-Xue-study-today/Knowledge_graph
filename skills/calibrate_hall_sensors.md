# Skill: Calibrate Hall Sensors

## Purpose

Generate a linearization table for hall sensors to improve rotor position estimation for field‑oriented control.

## Inputs

- Hall sensor signals captured at high resolution.
- Timer or encoder counts between hall transitions.
- Number of electrical pole pairs.

## Procedure

1. Rotate the motor at constant speed and record time intervals between hall edges over one mechanical revolution.
2. Divide the electrical cycle into equal segments (e.g., 256 points).
3. Compute incremental electrical angle for each segment based on measured periods.
4. Construct a lookup table mapping timer counts to cumulative angle.
5. Store the table in firmware and use interpolation to estimate angle between hall events.

## Validation

Compare reconstructed electrical angle with high‑resolution encoder data or sensorless estimator and verify that torque ripple due to commutation reduces.