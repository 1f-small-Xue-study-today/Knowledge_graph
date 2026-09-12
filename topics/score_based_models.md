---
id: score_based_models
type: topic
name: Score-Based Generative Models
level: intermediate
status: in_progress
prerequisites:
  - probability
  - generative_math_foundations
related:
  - diffusion_models
  - flow_matching
last_updated: 2026-09-12
---

# Score-Based Generative Models

**Learning status: In progress — not yet fully understood / 尚未完全理解.**

Open the [interactive score-based modeling lesson](../demo/score_based_models/scripts/index.html). It explains the data-space score, Gaussian smoothing, denoising score matching, Langevin dynamics, annealing, and the connections to DDPM and probability-flow ODEs.

Interactive demonstrations use an analytically known toy distribution: a density/score probe, a two-dimensional field with a rotatable 3D log-density landscape, and sampling versus gradient ascent. They do not train a neural network.

The [3D spatial score field](../demo/score_based_models/scripts/index.html#space3d) uses x, y, and z as actual data coordinates. It includes draggable rotation, a vector probe, score arrows, particle trails, and animated Langevin versus deterministic ascent. This is separate from the log-density landscape, whose height encodes log density.

## Learning checkpoints

- Explain why the score is a vector, not a probability or quality rating.
- Distinguish derivatives with respect to data from gradients with respect to parameters.
- Derive the Gaussian corruption target −ε/σ and explain its conditional-average optimum.
- Distinguish optimization from sampling, including Langevin noise and finite-step bias.
- Relate score prediction to DDPM noise prediction, and score fields to generative drift fields.

The previous VAE, DDPM, and Flow Matching lessons retain their existing learning statuses.
