---
id: action_chunking
type: topic
name: Action Chunking and Temporal Policies
level: intermediate
status: not_started
prerequisites:
  - behavior_cloning
  - robot_trajectory_optimization
related:
  - diffusion_policy
last_updated: 2026-08-29
---

# Action Chunking and Temporal Policies

## Overview

Modern manipulation policies output a sequence \(A_t=[a_t,\ldots,a_{t+H-1}]\) instead of a single \(a_t\), then execute only the first portion and replan. This is receding-horizon execution applied to a learned policy.

## Concepts

- Observation horizon \(H_o\), prediction horizon \(H_p\), action horizon \(H_a\).
- Temporal correlation across a chunk; why chunking smooths behavior.
- Why chunking shortens the effective decision horizon and reduces compounding error.

## Connection to MPC

| MPC | Chunked learned policy |
|---|---|
| \(U^\star_{t:t+H}=\arg\min_U J(x_t,U)\) | \(A_{t:t+H}\sim p_\theta(A\mid O_t)\) |
| execute first portion, replan | execute first portion, requery |

The structure is analogous, but sampling from a learned distribution is not solving an online constrained optimization problem — no constraints are enforced by the policy itself.

## ACT as the Non-Generative Baseline

*Learning Fine-Grained Bimanual Manipulation with Low-Cost Hardware*, Zhao et al., 2023 (https://arxiv.org/abs/2304.13705). It isolates chunking + Transformer sequence modeling + temporal aggregation without diffusion.

Questions to answer: what ACT predicts, its observation input, chunk length, how chunking mitigates compounding error, how it differs from Diffusion Policy, which has the simpler inference path.

## Exit Criterion

I can distinguish single-step BC vs action-chunk BC vs generative action-chunk policy.
