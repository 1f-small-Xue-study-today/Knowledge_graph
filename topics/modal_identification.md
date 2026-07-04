---
id: modal_identification
type: topic
name: Modal Identification
level: advanced
status: learned
prerequisites:
  - frf_analysis
related:
  - frf_analysis
  - pmsm_model
  - robust_frequency_domain_optimization
last_updated: 2026-07-04
---

# Modal Identification

## Overview

Modal identification determines resonance frequencies, damping ratios, mode shapes, and equivalent dynamic parameters from measured input/output data. It is useful for motor systems, gimbals, and robot mechanisms because the controller must avoid exciting flexible modes, structural resonance, gear-train resonance, and sensor/actuator bandwidth limits.

For motor-control work, modal identification connects frequency response data to physical parameters such as inertia, damping, stiffness, backlash/friction effects, current-loop bandwidth, torque constant uncertainty, load coupling, and mechanical resonance.

## Parameters To Identify

- **Resonance and anti-resonance:** natural frequencies, notch locations, flexible coupling, and structural modes.
- **Damping:** modal damping ratio, viscous damping, and effective friction behavior.
- **Motor/electrical parameters:** resistance, inductance, torque constant, back-EMF constant, and current-loop response.
- **Mechanical parameters:** inertia, stiffness, damping, Coulomb/viscous friction, gear/load coupling, and payload-dependent changes.
- **Control-relevant limits:** bandwidth, phase delay, saturation behavior, sensor noise, and stability margins.

## Identification Algorithms

- **FRF peak picking:** quickly estimates resonant frequencies and approximate damping from measured Bode plots.
- **Curve fitting:** fits second-order modal models, transfer functions, or rational functions to FRF data.
- **Least-squares model fitting:** estimates ARX, ARMAX, output-error, Box-Jenkins, or transfer-function coefficients from time-domain data.
- **Subspace identification:** extracts state-space models from measured input/output data, useful for multi-mode systems.
- **ERA and impulse-response fitting:** identifies modal models from impulse or free-decay responses.
- **Recursive least squares:** tracks parameter changes online, such as load inertia or friction variation.
- **Prediction-error methods:** refine model parameters by minimizing measured-versus-predicted output error.

## Motor And Gimbal Use

In motor and gimbal systems, modal identification supports:

1. Designing notch filters for resonance suppression.
2. Choosing safe loop bandwidth and phase margin.
3. Estimating mechanical load parameters for feedforward and observer design.
4. Updating robust frequency-domain controller weights and uncertainty ranges.
5. Diagnosing failures caused by flexible modes, loose mechanics, friction, or sensor delay.

## Learning Update (2026-07-04)

- Learned modal identification concepts around resonance, motor-system parameters, mechanical parameters, and related model-identification algorithms.
