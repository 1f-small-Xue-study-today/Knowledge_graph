# Project: Gimbal Disturbance Rejection Project

## Description

This project focuses on implementing robust disturbance rejection techniques for a three‑axis camera gimbal. The goal is to maintain stable orientation under external disturbances and mechanical coupling.

## Requirements

- Implement LADRC controller and extended state observers on each axis.
- Design feedforward and decoupling strategies for axis coupling.
- Develop cogging and friction compensation modules.
- Validate performance under vibrational disturbances and platform motion.

## Milestones

1. **Model Identification:** Develop or refine PMSM and gimbal dynamic models, including inertia and coupling terms.
2. **Observer and Controller Implementation:** Implement ESO and LADRC for each axis and integrate cogging/friction compensation.
3. **Integration and Tuning:** Combine components on the HC32F460 platform; tune gains through simulation and experiments.
4. **Testing and Validation:** Evaluate disturbance rejection performance using controlled disturbance inputs and field tests.