# Kalman Filter

## Overview

The Kalman filter is an optimal estimator for linear dynamical systems with Gaussian noise.  It estimates the hidden state \(x_k\) of a system governed by the discrete state equation

\[
x_{k+1} = A x_k + B u_k + w_k
\]

and measurement equation

\[
z_k = H x_k + v_k
\]

where \(w_k\) and \(v_k\) are zero‑mean Gaussian noise with covariances \(Q\) and \(R\).  The filter recursively predicts and updates the state estimate \(\hat{x}_k\) and error covariance \(P_k\).

## Algorithm

**Prediction**
\[
\hat{x}_{k|k-1} = A \hat{x}_{k-1|k-1} + B u_{k-1},\quad P_{k|k-1} = A P_{k-1|k-1} A^\top + Q
\]

**Update**
Compute the innovation \(y_k = z_k - H\hat{x}_{k|k-1}\) and the innovation covariance \(S_k = H P_{k|k-1} H^\top + R\).  The Kalman gain is

\[
K_k = P_{k|k-1} H^\top S_k^{-1}.
\]

Update the state estimate and error covariance:

\[
\hat{x}_{k|k} = \hat{x}_{k|k-1} + K_k y_k,\quad P_{k|k} = (I - K_k H) P_{k|k-1}.
\]

## Applications

In motor control and robotics, the Kalman filter is used for:

- Current and speed estimation
- IMU attitude estimation
- Sensor fusion for state observers

Efficient embedded implementations require careful handling of matrix operations and numerical stability.
