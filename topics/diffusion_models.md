---
id: diffusion_models
type: topic
name: Diffusion Model Fundamentals (DDPM)
level: intermediate
status: not_started
prerequisites:
  - probability
  - numerical_optimization
related:
  - conditional_diffusion
  - flow_matching
last_updated: 2026-08-29
---

# Diffusion Model Fundamentals (DDPM)

This is the mathematical core of the track. Work it out on 1-D/2-D toy distributions, never on robot images.

## Forward Process

\[
q(x_k\mid x_{k-1})=\mathcal N(\sqrt{\alpha_k}x_{k-1},(1-\beta_k)I),\quad
\alpha_k=1-\beta_k,\quad \bar\alpha_k=\prod_{i\le k}\alpha_i
\]

Closed-form marginal to derive by hand:

\[
x_k=\sqrt{\bar\alpha_k}\,x_0+\sqrt{1-\bar\alpha_k}\,\epsilon,\qquad \epsilon\sim\mathcal N(0,I)
\]

Understand the role of the noise schedule \(\beta_k\) and why \(x_K\) approaches a simple Gaussian.

## Reverse Process

Learn \(p_\theta(x_{k-1}\mid x_k)\) through the noise-prediction parameterization \(\epsilon_\theta(x_k,k)\):

\[
\mathcal L=\mathbb E\big[\|\epsilon-\epsilon_\theta(x_k,k)\|_2^2\big]
\]

Understand: why predicting noise is enough to get the denoising direction; why one network conditioned on \(k\) handles all noise levels; how training differs from sampling; why inference starts from pure noise.

## Score Interpretation

\(s_\theta(x,k)\approx\nabla_x\log p_k(x)\) is a vector field pointing toward higher density. Contrast with \(-\nabla J(x)\) from optimization: descent on a *designed* objective vs ascent on a *learned* log-density.

## Exit Criterion

Explain without notes: (1) why noise is added during training, (2) what the network predicts, (3) how generation starts from noise, (4) why repeated denoising recovers samples from a complicated distribution.
