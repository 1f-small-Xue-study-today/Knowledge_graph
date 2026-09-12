---
id: vae
type: topic
name: Variational Autoencoders
level: beginner
status: in_progress
prerequisites:
  - generative_math_foundations
related:
  - diffusion_models
  - flow_matching
last_updated: 2026-09-12
---

# Variational Autoencoders

**Learning status: In progress — not yet fully understood.** Revisit the lesson and learning checkpoints before marking this topic as learned.

Open the [interactive VAE lesson](../demo/vae/scripts/index.html). The standalone HTML works offline.

Includes encoder distributions, reparameterization, decoder likelihoods, ELBO and prior KL, beta weighting, actual gradient descent on a scalar linear Gaussian VAE, generation using the trained decoder, pseudocode, pitfalls, and exercises.

The Gaussian sampling controls illustrate individual operations. The training lab actually optimizes an exactly computable expected loss on eight scalar observations; it is not a trained image generator.

Learning checkpoint: distinguish prior, approximate posterior, and true posterior; trace reconstruction gradients through a sample; explain the loss reductions and KL sign; generate without an encoder; recognize posterior collapse.

Next topic: [DDPM](diffusion_models.md), with an [interactive diffusion lesson](../demo/ddpm/scripts/index.html). VAE remains in progress; opening the next topic does not mark it as understood.
