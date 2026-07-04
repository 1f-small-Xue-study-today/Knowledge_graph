# Skill: Design Robust Frequency-Domain Controller

## Purpose

Design and tune a robust motor controller from modeled or measured frequency response data, then translate the optimized controller into an embedded implementation.

## Inputs

- PMSM or actuator model, including sampling period and control-loop structure.
- Measured FRF or swept-sine data from command input to current, speed, or position output.
- Target bandwidth, gain margin, phase margin, disturbance rejection, and noise limits.
- Hardware constraints such as PWM frequency, ADC noise, computation time, saturation, and current limits.

## Procedure

1. Build the nominal plant model and uncertainty set from FRF measurements, load variation, and parameter tolerance.
2. Select frequency-domain objectives for sensitivity, complementary sensitivity, control effort, and resonance suppression.
3. Optimize controller parameters such as PI/PID gains, lead-lag filters, notch filters, or observer bandwidths.
4. Check robust stability and performance over the uncertainty set instead of only the nominal model.
5. Discretize the controller and verify delay, numeric range, saturation behavior, and fixed-point or floating-point limits.
6. Validate with small-signal tests first, then step, load-disturbance, and full-speed tests.

## Validation

- Confirm gain margin, phase margin, crossover frequency, and resonance attenuation from the closed-loop response.
- Compare measured hardware response against the optimized frequency-domain prediction.
- Verify that performance remains acceptable under motor/load variation and sensor-noise changes.
