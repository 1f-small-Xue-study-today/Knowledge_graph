# PID Control

## Overview

Proportional–Integral–Derivative (PID) control is a widely used feedback mechanism.  The control input \(u(t)\) is composed of three terms based on the error \(e(t) = r(t) - y(t)\):

\[
u(t) = K_p e(t) + K_i \int_0^t e(\tau)\,d\tau + K_d \frac{de(t)}{dt}.
\]

- **Proportional** \(K_p e(t)\) reduces the error proportionally.
- **Integral** \(K_i \int e\) eliminates steady‑state error.
- **Derivative** \(K_d \dot{e}\) anticipates future error and improves stability.

Discrete implementation often uses the incremental form to avoid integral windup.

## Tuning Methods

Several methods exist to choose gains \(K_p,K_i,K_d\), such as:

- Ziegler–Nichols step response or ultimate gain method
- Root locus or frequency response methods
- Manual tuning based on rise time, overshoot and settling time

## Applications

In motor control, PID loops are used for:

- Current regulation in FOC (inner loop)
- Speed control (outer loop)
- Gimbal angle control
