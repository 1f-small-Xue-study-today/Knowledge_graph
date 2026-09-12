---
id: diffusion_models
type: topic
name: Diffusion Model Fundamentals (DDPM)
level: intermediate
status: in_progress
prerequisites:
  - probability
  - numerical_optimization
related:
  - conditional_diffusion
  - flow_matching
last_updated: 2026-09-12
---

# Diffusion Model Fundamentals (DDPM)

**Learning status: In progress — not yet fully understood / 尚未完全理解.** Revisit the lesson and learning checkpoints before marking DDPM as learned.

Open the [interactive DDPM lesson](../demo/ddpm/scripts/index.html). It covers forward noising, noise-prediction training, stochastic reverse sampling, the ELBO connection, and common implementation mistakes. Its reverse-process lab uses an analytic denoiser for a known toy distribution, not a trained neural network.

DDPM means Denoising Diffusion Probabilistic Model. First study one-dimensional toy distributions, then move to higher-dimensional data. The [KL/Jensen foundations](generative_math_foundations.md) are useful prerequisites; full mastery of VAE is not required to start.

## Forward Process

\[
q(x_k\mid x_{k-1})=\mathcal N(\sqrt{\alpha_k}x_{k-1},\beta_k I),\quad
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
