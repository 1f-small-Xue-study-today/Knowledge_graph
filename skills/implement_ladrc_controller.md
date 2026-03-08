# Skill: Implement LADRC Controller

## Purpose

Develop and tune a linear active disturbance rejection controller for a PMSM or gimbal axis that estimates and compensates disturbances in real time.

## Inputs

- Plant parameters (inertia, torque constant, sampling period).
- Desired closed‑loop bandwidths for the controller and observer.
- Sensor measurements (current, speed or angle).

## Procedure

1. Design an extended state observer (ESO) to estimate states and total disturbance; select observer bandwidth at least three times greater than controller bandwidth.
2. Compute feedback gains based on desired closed‑loop poles; typical LADRC uses state feedback with disturbance cancellation.
3. Implement tracking differentiator if reference signals require smoothing.
4. Discretize the ESO and control law for the MCU; ensure sampling frequency is sufficiently high.
5. Tune observer and controller gains through simulation and experimentation.

## Validation

- Apply step and disturbance tests and observe that tracking error and disturbance rejection meet specifications.
- Verify stability under parameter variations and measurement noise.