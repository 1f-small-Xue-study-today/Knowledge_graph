# Phase‑Locked Loop (PLL)

## Overview

A phase‑locked loop synchronises the phase of a locally generated signal with a reference signal.  In motor control, PLLs estimate the electrical angle of the rotor for synchronous sampling.

A digital PLL typically consists of:

1. **Phase Detector:** Measures the phase error between the reference and the oscillator output.
2. **Loop Filter:** Low‑pass filters the error to produce a control signal.
3. **Numerically Controlled Oscillator (NCO):** Integrates the control signal to produce the estimated phase.

## Implementation Steps

1. **Signal Extraction:** Sample the measured back‑EMF or hall sensor signals to obtain a phase estimate.
2. **Phase Detector:** Compute the phase error between the estimated and measured phase.
3. **Loop Filter:** Use a PI controller to filter the error and generate frequency correction.
4. **Integrator:** Integrate the corrected frequency to update the estimated angle: \(\theta_{\text{est}}(k+1) = \theta_{\text{est}}(k) + \Delta t\,(\omega_{\text{est}} + \omega_{\text{corr}})\).
5. **Anti‑Wrap:** Constrain the angle to \([0,2\pi)\) to handle wrap‑around.
6. **Parameter Tuning:** Choose PI gains based on desired lock‑in speed and noise attenuation.

## Importance

Accurate angle estimation is critical for FOC.  The PLL must be robust against noise and parameter variation.
