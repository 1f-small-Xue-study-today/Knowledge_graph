# IMU Sensor Fusion

## Overview

An inertial measurement unit (IMU) typically comprises gyroscopes, accelerometers and magnetometers.  Sensor fusion algorithms combine these measurements to estimate orientation (roll, pitch, yaw) or full attitude quaternions.

A common approach uses an extended Kalman filter (EKF) or complementary filter.  The gyroscope measures angular rate \(\omega\), the accelerometer measures specific force (including gravity), and the magnetometer measures Earth’s magnetic field.

## Typical Steps

1. **Calibration:** Correct biases and scale factors for each sensor.
2. **Prediction:** Propagate orientation using gyroscope rates.  If using quaternions \(q\):

\[
\dot{q} = \tfrac{1}{2} \Omega(\omega) q
\]

where \(\Omega(\omega)\) forms a quaternion multiplication matrix.
3. **Update:** Use accelerometer and magnetometer to correct drift by comparing measured and expected direction of gravity and magnetic field.
4. **Normalization:** Re-normalize the quaternion to unit length to prevent drift.

## Representations

Quaternions avoid singularities of Euler angles.  A unit quaternion \(q=[q_0,q_1,q_2,q_3]^\top\) represents a rotation, and attitude can be applied to a vector \(v\) via \(v' = q v q^{-1}\).

## Applications

- Stabilizing gimbals
- Drone and robot attitude estimation
- Augmented reality devices
