---
id: flow_matching
type: topic
name: Conditional Flow Matching
level: advanced
status: not_started
prerequisites:
  - diffusion_models
  - state_space_model
related:
  - consistency_models
  - vision_language_action_models
last_updated: 2026-08-29
---

# Conditional Flow Matching

## Overview

Instead of a stochastic denoising chain, learn a velocity field transporting a simple distribution to the data distribution:

\[
\frac{dx}{dt}=v_\theta(x,t\mid o)
\]

This is a controlled ODE \(\dot x=f_\theta(x,t,o)\), so inference is numerical integration — directly familiar from the control/planning background.

## Questions

- What are the source and target distributions?
- What velocity field is learned, and against what target?
- Euler vs higher-order integration; how many steps are needed?
- Why can the transport path be straighter than a diffusion sampling path?

## Representative Work

- Chisari et al., *Manipulation Policies from Point Clouds with Conditional Flow Matching*, CoRL 2025 — https://proceedings.mlr.press/v270/chisari25a.html
- Black et al., *\(\pi_0\)* — https://arxiv.org/abs/2410.24164
