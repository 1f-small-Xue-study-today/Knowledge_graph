# Skill: Design LQR Controller

## Purpose

Design and implement an LQR controller for stabilizing systems such as gimbals or speed loops.

## Procedure

1. **Model Identification:** Derive or identify the linearised state‑space model \((A,B)\) of the plant.
2. **Select Weightings:** Choose \(Q\) to penalise deviations of states and \(R\) to penalise control effort.  Diagonal matrices are often used for simplicity.
3. **Solve Riccati Equation:** Use numerical algorithms (e.g., MATLAB `lqr` function) or implement a discrete Riccati solver in C.
4. **Compute Gain:** \(K = R^{-1} B^\top P\).
5. **Implement Control Law:** In each control loop, compute \(u = -K x\) using measured or estimated state \(x\).
6. **Integrate with Observer:** Pair the LQR with a state observer or Kalman filter if the full state is not directly measured.

## Notes

- The choice of \(Q\) and \(R\) affects closed‑loop dynamics; tune them iteratively.
- Ensure that \((A,B)\) is stabilisable and \((A,Q^{1/2})\) is detectable for a valid solution.
