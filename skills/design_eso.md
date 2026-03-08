# Skill: Design Extended State Observer

## Purpose

Construct an observer that estimates both the system states and an aggregated disturbance for use in LADRC or robust control.

## Inputs

- State‑space model matrices \(A\), \(B\), \(C\) or approximations.
- Desired observer bandwidth \(\omega_o\).
- Sampling period and measurement noise characteristics.

## Procedure

1. Augment the original state vector with a disturbance state.
2. Choose observer poles located at \(-\omega_o\) for each augmented dimension.
3. Compute observer gain matrix \(L\) using pole placement or optimal estimation techniques.
4. Implement discrete‑time observer update on the MCU.
5. Test the observer using simulated or measured data to ensure convergence and disturbance tracking.

## Validation

Assess estimation accuracy by comparing observer states with measured variables and ensure the estimated disturbance captures unmodeled dynamics and external loads.