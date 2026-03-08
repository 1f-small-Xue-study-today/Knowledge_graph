# Linear Quadratic Regulator (LQR)

## Overview

The LQR is an optimal state‑feedback controller for linear systems \( \dot{x} = A x + B u\).  It minimises the cost functional

\[
J = \int_0^\infty (x^\top Q x + u^\top R u)\,dt,
\]

with symmetric positive‑semi‑definite \(Q\) and positive‑definite \(R\).  The optimal control law is

\[
u = -K x,
\]

where \(K = R^{-1} B^\top P\) and \(P\) is the positive‑definite solution of the Algebraic Riccati Equation (ARE):

\[
A^\top P + P A - P B R^{-1} B^\top P + Q = 0.
\]

## Steps to Design

1. **Select Weightings:** Choose weighting matrices \(Q\) and \(R\) to reflect state and input penalties.
2. **Solve Riccati Equation:** Use numerical algorithms (e.g., MATLAB `lqr` function) or implement a discrete Riccati solver in C.
3. **Compute Gain:** \(K = R^{-1} B^\top P\).
4. **Implement Control Law:** In each control loop, compute \(u = -K x\) using measured or estimated state \(x\).
5. **Integrate with Observer:** Pair the LQR with a state observer or Kalman filter if the full state is not directly measured.

## Applications

LQR is used in:

- Gimbal stabilization
- Attitude control of spacecraft and drones
- Robust control of motor drives

Because it requires full state feedback, an observer (e.g., Kalman filter) is often paired with LQR.
