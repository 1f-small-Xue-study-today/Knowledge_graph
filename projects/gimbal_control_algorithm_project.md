# Project: Gimbal Control Algorithm Implementation

## Description

Design and implement a three‑axis gimbal control system.  The objective is to stabilise the camera orientation in the presence of motion using optimal control and sensor fusion.

## Requirements

- Implement IMU sensor fusion (e.g., EKF) to estimate orientation.
- Design an LQR or PID controller to regulate each axis angle.
- Compensate for actuator saturation and mechanical coupling.
- Develop calibration procedures for sensors and encoders.
- Provide user interface for tuning gains and viewing status.

## Milestones

1. **IMU Integration:** Interface gyroscope, accelerometer and magnetometer, and implement sensor fusion.
2. **Plant Modelling:** Identify or derive the dynamics of each gimbal axis.
3. **Controller Design:** Choose LQR or PID, select weightings and compute gain matrices.
4. **Implementation:** Write firmware for control loops on the MCU.
5. **Testing:** Evaluate stabilisation performance under different motion profiles.
