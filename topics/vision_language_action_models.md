---
id: vision_language_action_models
type: topic
name: Vision-Language-Action Models and Robot Foundation Policies
level: advanced
status: not_started
prerequisites:
  - diffusion_policy
  - flow_matching
related: []
last_updated: 2026-08-29
---

# Vision-Language-Action Models (VLA)

Enter only after a small generative policy is fully understood. A large VLA introduces visual representation learning, language conditioning, Transformers, large-scale pretraining, heterogeneous datasets, action tokenization, generative decoding, and embodiment transfer all at once.

## Abstraction Shift

\[
p(A\mid I,q)\quad\longrightarrow\quad p(A\mid I,q,\text{language})
\]

with large-scale pretraining across robots and tasks.

## Important Separation

"VLA" describes the **conditioning modalities and scale**, not the action-generation mechanism. A VLA may use autoregressive action tokens, diffusion, flow matching, or another continuous head — \(\pi_0\) is flow-based, RDT is diffusion-based.

## Study Dimensions

Vision encoder · language/VLM backbone · proprioception · action representation · chunking · action decoder type · cross-embodiment normalization · fine-tuning and PEFT · dataset scaling · morphology differences.

## Representative Models

- Octo — https://arxiv.org/abs/2405.12213
- OpenVLA — https://arxiv.org/abs/2406.09246
- RDT-1B — https://arxiv.org/abs/2410.07864
- \(\pi_0\) — https://arxiv.org/abs/2410.24164
- LeRobot VLA implementations — https://huggingface.co/docs/lerobot/
