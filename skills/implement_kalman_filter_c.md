# Skill: Implement Kalman Filter in C

## Purpose

Write efficient C code to perform Kalman filtering on the HC32F460 or similar MCUs.

## Procedure

1. **Define System Matrices:** Determine \(A,B,H,Q,R\) for the physical system (e.g., observer for speed or position).
2. **Initial Conditions:** Choose initial state estimate \(\hat{x}_0\) and covariance \(P_0\).
3. **Matrix Operations:** Implement prediction and update steps.  Use efficient matrix libraries or manually unroll small matrix multiplications.
4. **Fixed‑Point Considerations:** If floating‑point is unavailable, convert matrices to fixed‑point representation and scale appropriately.
5. **Avoid Overflow:** Monitor ranges and use saturation arithmetic if needed.
6. **Testing:** Validate the filter with simulated noisy data before deploying to hardware.

## Notes

- Kalman filters are sensitive to modelling errors.  Tune \(Q\) and \(R\) to reflect actual process and measurement noise.
- Consider square‑root or U‑DU factorisation forms for improved numerical stability.
