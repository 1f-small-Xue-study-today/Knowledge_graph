# Skill: Tune PID Controllers

## Purpose

Optimise the gains of PID controllers for current and speed loops.

## Procedure

1. **Model Identification:** Estimate the plant dynamics (e.g., motor plus inverter) via step response or frequency response.
2. **Initial Guess:** Use heuristics such as Ziegler–Nichols to compute initial \(K_p,K_i,K_d\).
3. **Simulation:** Simulate the closed‑loop system in MATLAB or Python to evaluate rise time, overshoot, settling time and steady‑state error.
4. **Iterative Tuning:** Adjust gains based on performance criteria.  Increase \(K_p\) to reduce rise time, increase \(K_i\) to eliminate steady‑state error, and adjust \(K_d\) to reduce overshoot.
5. **Implementation:** Load the tuned gains into the MCU and verify performance with hardware‑in‑loop tests.
6. **Robustness Checks:** Test under varying load and supply conditions to ensure stability.
