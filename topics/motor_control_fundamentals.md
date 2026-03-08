# Motor Control Fundamentals

## Overview

Motor control involves regulating the electromagnetic torque and speed of electric machines.  A basic DC or brushless motor obeys both electrical and mechanical dynamics.  The mechanical dynamics relate torque \(T_e\) to the rotor speed \(\omega\) via

\[
J\,\dot{\omega} + B\omega = T_e - T_{\text{load}}
\]

where \(J\) is the inertia, \(B\) the viscous friction, \(T_e\) the electromagnetic torque and \(T_{\text{load}}\) the disturbance or load torque.

The electrical dynamics describe how phase voltages \(v\) produce currents \(i\) and back‑EMF \(e\):

\[
v = R\,i + L \,\frac{di}{dt} + e
\]

with resistance \(R\) and inductance \(L\).  For a permanent‑magnet synchronous motor, the back‑EMF is proportional to speed: \(e = K_e\,\omega\).

## Importance

Understanding these fundamental equations is essential for developing control algorithms such as field‑oriented control (FOC).  They form the basis for modelling, simulation and controller design.

## Key Concepts

- Torque and speed relationship
- Electrical circuit equations
- Inertia and friction effects
- Load disturbances
