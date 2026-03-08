# Skill: Implement Friction Compensation

## Purpose

Model and compensate friction effects to improve control accuracy at low speeds and during reversals.

## Inputs

- Experimental data of torque versus velocity around zero speed.
- Friction model parameters (Coulomb, viscous, Stribeck).

## Procedure

1. Conduct experiments to measure friction torque across speed range.
2. Fit a friction model \(T_f = T_c \operatorname{sign}(\omega) + B \omega + \Delta(\omega)\) capturing static and dynamic components.
3. Implement a feedforward term that subtracts the estimated friction torque from the control law.
4. Update model parameters periodically to account for wear or lubrication changes.
5. Ensure friction compensation does not cause chattering or instability at very low speeds.

## Validation

Evaluate tracking error and torque command at low velocities with and without friction compensation; ensure smoother transitions.