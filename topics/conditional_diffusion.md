---
id: conditional_diffusion
type: topic
name: Conditional Diffusion
level: intermediate
status: not_started
prerequisites:
  - diffusion_models
related:
  - diffusion_policy
last_updated: 2026-08-29
---

# Conditional Diffusion

## Overview

A robot policy needs \(p(A\mid O)\), not \(p(A)\). The change is a conditioning input to the denoiser:

\[
\epsilon_\theta(A_k,k,c)
\]

where \(c\) may hold images, proprioception, task instruction, object state, or goal state.

## Toy Experiment

Two-context dataset: condition 0 → trajectories going left, condition 1 → trajectories going right. Train one conditional model and check that samples respect the condition.

## Variable Mapping to Robotics

| Toy diffusion | Robot manipulation |
|---|---|
| \(x_0\) | clean action chunk \(A_0\) |
| \(x_k\) | noisy action chunk \(A_k\) |
| condition \(c\) | observation \(O_t\) |
| denoiser | action denoising network |
| generated sample | candidate action trajectory |
| repeated sampling | repeated closed-loop policy query |

## Exit Criterion

I understand that Diffusion Policy is primarily conditional diffusion in robot action space.
