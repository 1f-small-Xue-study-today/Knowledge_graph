# Skill: Perform Motor Failure Analysis

## Purpose

Diagnose motor-control failures by connecting symptoms, logs, electrical measurements, mechanical behavior, and controller structure to likely root causes.

## Inputs

- Motor type, driver hardware, encoder or Hall sensor setup, and controller architecture.
- Fault logs, current/voltage/speed/position traces, and operating conditions.
- Parameters such as resistance, inductance, torque constant, inertia, friction, current limits, and PWM frequency.
- Recent code, calibration, wiring, or mechanical changes.

## Procedure

1. Classify the symptom: no start, oscillation, overcurrent, overheating, torque ripple, tracking error, position jump, noise, or shutdown.
2. Separate electrical, sensing, mechanical, and control-loop causes.
3. Check power stage, phase wiring, encoder/Hall polarity, current-sensor offset, ADC scaling, and PWM/dead-time behavior.
4. Review controller tuning, observer behavior, saturation handling, anti-windup, and sample-time consistency.
5. Reproduce the issue with low-risk tests and capture synchronized command, feedback, current, voltage, and fault-state data.
6. Identify the most likely root cause and define corrective actions plus regression tests.

## Validation

- Confirm that the failure can be reproduced before the fix and disappears after the fix.
- Verify the fix across speed, load, voltage, and temperature ranges.
- Record the failure signature and final root cause for future debugging.
