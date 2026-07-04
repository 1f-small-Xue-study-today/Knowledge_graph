# Skill: Perform Gimbal Failure Analysis

## Purpose

Diagnose gimbal-control failures by analyzing attitude response, motor behavior, sensor feedback, mechanical balance, and disturbance-rejection performance.

## Inputs

- Gimbal axis configuration, motor and driver details, IMU/encoder data, and controller structure.
- Logs for attitude error, angular rate, motor current, observer states, and command signals.
- Mechanical information such as payload balance, friction, cable drag, backlash, and axis coupling.
- Recent calibration, firmware, parameter, or payload changes.

## Procedure

1. Classify the symptom: drift, vibration, hunting, saturation, pointing error, axis coupling, startup failure, or disturbance-rejection failure.
2. Check IMU alignment, encoder polarity, motor phase order, axis sign conventions, and calibration data.
3. Inspect mechanical balance, friction, loose structure, cable tension, payload changes, and resonance.
4. Review PID/LADRC/DOB/ESO parameters, observer bandwidth, filtering, delay, and saturation handling.
5. Reproduce the issue using controlled motion and disturbance tests while logging attitude, rate, current, and observer estimates.
6. Map the failure to root cause and define a fix, validation test, and future detection signal.

## Validation

- Verify pointing accuracy, stabilization time, and disturbance rejection before and after the fix.
- Confirm that the issue does not reappear under payload, motion, and vibration changes.
- Save failure signatures and corrective actions for future gimbal-debugging work.
