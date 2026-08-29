---
id: behavior_cloning
type: topic
name: Behavior Cloning and Multimodal Action Distributions
level: beginner
status: not_started
prerequisites:
  - probability
  - robotics_kinematics_dynamics
related:
  - action_chunking
  - diffusion_policy
last_updated: 2026-08-29
---

# Behavior Cloning and Multimodal Action Distributions

## Overview

Behavior cloning (BC) fits a policy to a demonstration dataset \(\mathcal D=\{\tau_i\}\), \(\tau_i=(o_0,a_0,o_1,a_1,\ldots)\), by supervised regression \(\hat a_t=\pi_\theta(o_t)\) under an MSE loss. The MSE objective is a Gaussian likelihood assumption, so its optimum is the conditional mean.

## Core Results to Derive

- \(\mathcal L_{\mathrm{BC}}=\mathbb E_{(o,a)}\|a-\pi_\theta(o)\|_2^2\) is minimized by \(\pi^\star(o)=\mathbb E[a\mid o]\).
- When \(p(a\mid o)\) is multimodal, \(\mathbb E[a\mid o]\) can be an *invalid* command (averaging "go left" and "go right" gives "drive into the obstacle").
- Covariate shift: training observations come from the expert distribution, rollout observations come from the policy distribution, producing compounding error.

## Probabilistic Policies

- Conditional density \(p(a\mid o)\); Gaussian policy \(\mathcal N(\mu_\theta(o),\Sigma_\theta(o))\) trained by NLL.
- Distinguish epistemic uncertainty, action stochasticity, and genuinely multimodal expert behavior.
- A single Gaussian is still insufficient for strongly multimodal manipulation — this is the gap that generative policies fill.
- High-level awareness only at this stage: GMM, conditional VAE, autoregressive and energy-based policies.

## Relation to Classical Control

Classical: \(A^\star=\arg\min_A J(A)\) subject to a model and constraints.
Learned: \(A\sim p_\theta(A\mid O)\) fitted from demonstrations. Keep this distinction explicit throughout the whole track.

## Exit Criterion

I can explain, without notes, why robot imitation learning should model a distribution over actions rather than one deterministic action.

## Related

- Demo: `demo/behavior_cloning/`
- Skill: `skills/implement_toy_diffusion_pytorch.md`
