---
id: robust_frequency_domain_optimization
type: topic
name: Robust Frequency-Domain Optimization
level: advanced
status: learned
prerequisites:
  - control_theory
  - frf_analysis
  - pmsm_model
  - optimal_control
related:
  - foc
  - ladrc
  - advanced_motor_control_project
last_updated: 2026-07-04
---

# Robust Frequency-Domain Optimization

## Overview

Robust frequency-domain optimization designs a controller by shaping the loop response directly in the frequency domain. For motor control, it is useful when the plant has uncertain inertia, friction, torque constant, sampling delay, current-loop bandwidth, or mechanical resonance.

The design goal is not only high bandwidth, but stable performance under plant variation. Typical objectives include tracking bandwidth, disturbance rejection, noise attenuation, phase margin, gain margin, and limited control effort.

## Key Ideas

- Use measured or modeled frequency response data to describe the motor and load dynamics.
- Shape open-loop gain so the crossover frequency is high enough for tracking but below resonance, delay, and noise limits.
- Optimize sensitivity \(S = 1 / (1 + L)\) for disturbance rejection and complementary sensitivity \(T = L / (1 + L)\) for noise and resonance control.
- Treat motor parameter changes and load changes as uncertainty, then verify stability margins across the full operating range.
- Prefer filters, notch terms, lead-lag compensation, or robust loop-shaping updates that can be implemented safely in the embedded control loop.

## Motor-Control Application

This method works well for motor control algorithms because it gives a clear link between measured frequency response and controller changes. It can improve bandwidth and disturbance rejection while avoiding unstable excitation of mechanical modes.

Practical workflow:

1. Measure or model the plant frequency response from command input to current, speed, or position output.
2. Identify bandwidth limits from delay, PWM/update rate, sensor noise, and mechanical resonance.
3. Choose target loop shape, margins, and weighting functions.
4. Optimize controller parameters in the frequency domain.
5. Validate the controller in simulation, then with low-amplitude hardware tests before full-load operation.

## Learning Update (2026-07-04)

- Learned robust control for frequency-domain optimization.
- Verified that this approach works well in the motor-control algorithm workflow.
