# Skill: Compare BC, ACT, and Diffusion Policy

## Purpose

Run the same manipulation setting under three policy classes and determine where generative modeling actually pays, instead of treating diffusion as a default.

## Inputs

- One fixed task, dataset, observation space, and action space.
- Deterministic BC, ACT, and Diffusion Policy implementations.

## Procedure

1. Fix everything except the policy class; log the controlled variables explicitly.
2. Train all three to convergence with comparable budgets.
3. Evaluate task success, inference latency, trajectory smoothness, disturbance recovery, and generalization outside the demonstration manifold.
4. Add a genuinely multimodal variant of the task (two valid strategies) and re-evaluate.
5. Answer: where does diffusion buy something — multimodality, long temporal correlation, precision, disturbance recovery, dataset heterogeneity, or contact behavior?

## Validation

Each claimed advantage is tied to a measured metric and a hypothesis stated before the run, not chosen after seeing results.
