---
id: flow_matching
type: topic
name: Flow Matching and Conditional Flow Matching
level: advanced
status: in_progress
prerequisites:
  - diffusion_models
  - state_space_model
related:
  - consistency_models
  - vision_language_action_models
last_updated: 2026-09-12
---

# Flow Matching and Conditional Flow Matching

**Learning status: In progress — understanding not yet confirmed.**

Open the [interactive Flow Matching lesson](../demo/flow_matching/scripts/index.html). Start with linear interpolation and velocity regression, then explore the marginal velocity field and compare Euler with Heun integration. The sampler uses an analytic toy velocity field, not a trained network.

The lesson uses t = 0 for noise and t = 1 for data. Training samples an intermediate time directly; generation solves an ODE. It also distinguishes conditional flow-matching training from observation-conditioned generation. DDPM and VAE remain separate, unfinished learning topics.

The [3D field view](../demo/flow_matching/scripts/index.html#field3d) shows two data coordinates plus flow time, with rotatable velocity arrows, integrated particle trajectories, playback, and a numerical velocity probe. The third axis is time, not a third spatial coordinate.

## Overview

Instead of a stochastic denoising chain, learn a velocity field transporting a simple distribution to the data distribution:

\[
\frac{dx}{dt}=v_\theta(x,t\mid o)
\]

For fixed observation o, this is an ODE parameterized by context, so inference is numerical integration — familiar from the control/planning background. The integration variable t is generative time, not the robot's physical execution time, and this formulation alone does not imply closed-loop feedback or stability.

## Questions

- What are the source and target distributions?
- What velocity field is learned, and against what target?
- Euler vs higher-order integration; how many steps are needed?
- Why can the transport path be straighter than a diffusion sampling path?

## Representative Work

- Chisari et al., *Manipulation Policies from Point Clouds with Conditional Flow Matching*, CoRL 2025 — https://proceedings.mlr.press/v270/chisari25a.html
- Black et al., *\(\pi_0\)* — https://arxiv.org/abs/2410.24164
