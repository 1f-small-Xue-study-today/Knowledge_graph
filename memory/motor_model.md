# Memory: Motor Model

This memory entry records the mathematical model of the motor for reference by the AI agent and development team.

## Equations

- **Electrical:** \(v = R\,i + L\,\frac{di}{dt} + e\), with \(e = K_e \omega\).
- **Mechanical:** \(J\,\dot{\omega} + B \omega = T_e - T_{\text{load}}\).
- **Torque Constant:** \(T_e = K_t i_q\) for FOC, where \(i_q\) is the quadrature current.

## Parameters

- Inertia \(J\) depends on the rotor and load mass.
- Friction coefficient \(B\) models viscous drag.
- Torque constant \(K_t\) and back‑EMF constant \(K_e\) relate electrical and mechanical quantities.

These equations are used by control algorithms such as LQR and observers.