# State‑Space Models

## Overview

A state‑space model represents a dynamical system by a set of first‑order differential or difference equations:

\[
\dot{x} = A x + B u,\quad y = C x + D u
\]

for continuous time, or

\[
x_{k+1} = A x_k + B u_k,\quad y_k = C x_k + D u_k
\]

for discrete time.  Here \(x\) is the state vector, \(u\) the input, \(y\) the output, and \(A,B,C,D\) are matrices.

## Importance

State‑space models support modern control techniques (LQR, Kalman filter) and facilitate multi‑input multi‑output (MIMO) systems.
