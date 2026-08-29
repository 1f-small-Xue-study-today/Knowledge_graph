---
id: diffusion_policy
type: topic
name: Diffusion Policy
level: advanced
status: not_started
prerequisites:
  - conditional_diffusion
  - action_chunking
related:
  - diffusion_policy_3d
  - flow_matching
last_updated: 2026-08-29
---

# Diffusion Policy

**Paper:** Chi et al., *Diffusion Policy: Visuomotor Policy Learning via Action Diffusion*, RSS 2023 / IJRR 2024 — https://arxiv.org/abs/2303.04137

Read in three passes.

## Pass 1 — System Level

Target abstraction:

\[
O_{t-H_o+1:t}\xrightarrow{\text{encoder}} z_t,\quad
A_K\sim\mathcal N(0,I),\quad
A_K\xrightarrow[\text{cond. }z_t]{\text{denoising}}A_0,\quad
A_0[0:H_a]\rightarrow\text{controller}
\]

Answer: observations, actions, learned distribution, why sequences, how the trajectory is executed, replanning frequency, and where classical control remains.

## Pass 2 — Mathematics

Forward diffusion in action space, conditional denoiser, noise-prediction objective, score view, sampler, and the three horizons. Write tensor shapes explicitly: \(O\in\mathbb R^{H_o\times D_o}\), \(A\in\mathbb R^{H_p\times D_a}\), images \(I\in\mathbb R^{H_o\times C\times H\times W}\).

## Pass 3 — Engineering

From the official implementation: trajectory normalization, sample-window extraction, episode-boundary handling, scheduler choice, training vs inference step counts, denoiser architecture, image-conditioning injection, action queueing/execution, and behavior when action and observation rates differ.

## Comparison Frame

| Property | BC | ACT | Diffusion Policy |
|---|---|---|---|
| action chunk | optional | yes | yes |
| multimodality | weak | latent | strong generative |
| inference passes | ~1 | ~1 | multiple |
| implementation complexity | low | medium | medium/high |
| real-time cost | low | low/moderate | moderate/high |

The question to keep asking is not "which succeeds more often" but **where diffusion is actually buying something** — multimodality, long temporal correlation, precision, disturbance recovery, dataset heterogeneity, or contact behavior.
