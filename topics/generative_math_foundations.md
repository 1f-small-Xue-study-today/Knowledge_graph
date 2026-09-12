---
id: generative_math_foundations
type: topic
name: Mathematical Foundations for Generative Models
level: beginner
status: not_started
prerequisites:
  - probability
  - linear_algebra
related:
  - numerical_optimization
  - diffusion_models
  - flow_matching
last_updated: 2026-09-12
---

# Mathematical Foundations for Generative Models

Open the [interactive HTML lesson](../demo/generative_math/scripts/index.html) in a browser. It works offline; keep its `scripts/` and `figures/` folders together to preserve the included Chinese KL infographic.

The lesson covers convex functions and their defining properties, Jensen’s inequality and equality conditions, KL divergence and its support/asymmetry properties, and their connection to maximum likelihood and the VAE evidence lower bound (ELBO). Includes interactive chord and probability demonstrations, worked calculations, and six exercises with answers.

## Learning checkpoint

- Explain why a convex function lies below a chord and above a tangent.
- Apply Jensen to squared values and to logarithms with the correct inequality direction.
- Compute discrete KL, including zero-probability cases, and explain why it is not a metric.
- Derive the ELBO and distinguish KL to the prior from KL to the true posterior.
- Explain why these results do not imply convex neural network training.

Next: multivariate Gaussians, Monte Carlo estimation, reparameterization, then a toy VAE and diffusion objectives.
