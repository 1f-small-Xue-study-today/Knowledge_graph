# Skill: Perform Modal Identification

## Purpose

Identify resonance, damping, motor parameters, mechanical parameters, and control-relevant dynamic models from measured motor, gimbal, or robot data.

## Inputs

- Frequency response functions, sweep data, impulse response, free-decay data, or logged command/feedback signals.
- Measured current, voltage, speed, position, attitude, torque estimate, or acceleration signals.
- Known motor and mechanism information such as resistance, inductance, torque constant, inertia estimate, gear ratio, payload, and sampling rate.
- Signal processing and model-fitting tools.

## Procedure

1. Preprocess data by removing bias, checking units, filtering obvious noise, and synchronizing command/feedback signals.
2. Identify resonance and anti-resonance from FRF magnitude/phase or time-domain oscillation.
3. Estimate damping ratio, natural frequency, and equivalent stiffness/inertia where the mode can be approximated by a second-order model.
4. Fit candidate models using peak picking, transfer-function curve fitting, ARX/ARMAX/OE/BJ models, ERA, subspace identification, RLS, or prediction-error methods.
5. Separate motor electrical parameters, mechanical parameters, and controller-induced effects such as current-loop delay or saturation.
6. Select the simplest model that explains the measured behavior and is useful for controller design.
7. Convert identified modes into control actions such as notch filters, loop-bandwidth limits, feedforward updates, observer parameters, or failure-analysis notes.

## Validation

- Reconstruct measured FRF or time-domain response from the identified model.
- Check residuals, coherence, and repeatability across operating points.
- Verify that identified parameters remain plausible under load, speed, voltage, and payload changes.
- Validate controller changes on low-risk tests before applying high-bandwidth or full-load operation.
