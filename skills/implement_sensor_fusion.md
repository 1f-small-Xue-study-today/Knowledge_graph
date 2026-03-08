# Skill: Implement Sensor Fusion Algorithm

## Purpose

Fuse IMU measurements to estimate orientation accurately in real time.

## Procedure

1. **Sensor Interface:** Acquire gyroscope, accelerometer and magnetometer data at a fixed sampling rate.
2. **Bias Estimation:** Continuously estimate and subtract sensor biases.
3. **Propagation:** Use the gyroscope data to propagate the quaternion or rotation matrix.
4. **Correction:** At each step, compare the predicted direction of gravity and magnetic field with accelerometer and magnetometer readings to compute an error.
5. **Update:** Apply a complementary gain or Kalman gain to correct the orientation estimate.
6. **Normalization:** Enforce unit norm on the quaternion after each update.
7. **Output:** Convert the quaternion to Euler angles or direction cosine matrix if needed for control.

## Validation

- Test with static and dynamic motions.
- Compare against a reference (e.g., high‑grade IMU or motion capture).
- Evaluate the effect of noise and vibration on the estimate.
