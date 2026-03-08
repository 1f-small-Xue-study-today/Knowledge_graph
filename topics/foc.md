# Field‑Oriented Control (FOC)

## Overview

Field‑oriented control is a high‑performance algorithm for three‑phase AC motors.  It transforms the stator currents into a rotating reference frame aligned with the rotor flux so that torque and flux can be controlled independently.

In the Clarke transform, three‑phase currents \((i_a,i_b,i_c)\) are projected onto a two‑axis stationary frame \((\alpha,\beta)\):

\[
i_\alpha = \tfrac{2}{3}(i_a - \tfrac{1}{2}i_b - \tfrac{1}{2}i_c),\quad i_\beta = \tfrac{2}{3}\tfrac{\sqrt{3}}{2}(i_b - i_c)
\]

The Park transform rotates \((i_\alpha,i_\beta)\) into the rotor reference frame using the electrical angle \(\theta_e\):

\[
\begin{bmatrix} i_d \\ i_q \end{bmatrix}
=
\begin{bmatrix} \cos\theta_e & \sin\theta_e \\ -\sin\theta_e & \cos\theta_e \end{bmatrix}
\begin{bmatrix} i_\alpha \\ i_\beta \end{bmatrix}
\]

Here \(i_d\) is the direct‑axis current controlling the flux, while \(i_q\) is the quadrature‑axis current generating torque.  By regulating \(i_d\) to zero and \(i_q\) to a desired value using PI controllers, one obtains fast and decoupled torque control.

## Typical Procedure

1. **Measure** phase currents and rotor electrical angle (e.g., via hall sensors or observer).
2. **Clarke transform:** Compute \((i_\alpha,i_\beta)\).
3. **Park transform:** Obtain \((i_d,i_q)\).
4. **Current control:** Use PI regulators to control \(i_d\) and \(i_q\) to their references.
5. **Inverse transforms:** Apply inverse Park and inverse Clarke transforms to generate duty cycles for the inverter.

## Advantages

- Decouples flux and torque control.
- Enables precise torque control over a wide speed range.
- Integrates naturally with position sensors or sensorless observers.
