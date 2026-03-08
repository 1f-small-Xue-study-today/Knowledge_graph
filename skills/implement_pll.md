# Skill: Implement Phase‑Locked Loop

## Purpose

Estimate the rotor electrical angle for FOC using a digital phase‑locked loop.

## Procedure

1. **Signal Extraction:** Obtain stator voltages or back‑EMF signals.  For hall sensors, measure transitions to estimate speed.
2. **Phase Detector:** Compute the phase error \(e_\theta = \theta_\text{meas} - \theta_\text{est}\).
3. **Loop Filter:** Use a PI controller to filter \(e_\theta\) and generate frequency correction \(\omega_\text{corr}\).
4. **Integrator:** Integrate the corrected frequency to update the estimated angle: \(\theta_\text{est}(k+1) = \theta_\text{est}(k) + \Delta t\,(\omega_\text{est} + \omega_\text{corr})\).
5. **Anti‑Wrap:** Constrain the angle to \([0,2\pi)\) to handle wrap‑around.
6. **Parameter Tuning:** Choose PI gains based on desired lock‑in speed and noise attenuation.

## Validation

- Run the PLL with simulated inputs to observe tracking performance.
- Test at various speeds and under noise to ensure robustness.
