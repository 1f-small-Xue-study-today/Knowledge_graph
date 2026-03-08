---
id: pmsm_model
type: topic
name: PMSM Model
level: intermediate
status: unstudied
prerequisites:
  - motor_control_fundamentals
  - linear_algebra
  - control_theory
related:
  - foc
  - svpwm
last_updated: 2026-03-08
---

# PMSM Model

## Overview

A Permanent Magnet Synchronous Machine (PMSM) model captures the electrical and mechanical dynamics of brushless motors.  It is the foundation for field‑oriented control and advanced observers.

## Key Equations

- **Electrical dynamics:** $$v_d = R i_d + L_d \frac{d i_d}{dt} - \omega L_q i_q$$ and $$v_q = R i_q + L_q \frac{d i_q}{dt} + \omega L_d i_d + \omega \lambda_m.$$
- **Mechanical dynamics:** $$J\dot{\omega} = T_e - T_{\text{load}} - B\omega,$$ where \(T_e = \frac{3}{2} p \lambda_m i_q\).

## Notes

Identify parameters \(R\), \(L_d\), \(L_q\), \(J\), \(B\) and flux linkage \(\lambda_m\) experimentally or from datasheets. Use this model to design controllers and observers.