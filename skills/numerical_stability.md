# Skill: Numerical Stability

## Purpose

Ensure that algorithms implemented on embedded platforms are numerically robust.

## Guidelines

- **Scaling:** Scale variables to avoid overflow/underflow in fixed‑point arithmetic.
- **Conditioning:** Avoid subtracting nearly equal numbers to minimise loss of significance.
- **Normalization:** Re‑normalise quaternions and vectors to maintain unit length.
- **Filter Design:** Choose appropriate sampling rates and filter coefficients to prevent instability.
- **Testing:** Simulate with quantisation effects and measure sensitivity.
