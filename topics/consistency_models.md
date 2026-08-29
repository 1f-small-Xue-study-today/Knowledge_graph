---
id: consistency_models
type: topic
name: Consistency Models for Fast Policy Inference
level: advanced
status: not_started
prerequisites:
  - flow_matching
  - diffusion_policy
related: []
last_updated: 2026-08-29
---

# Consistency Models for Fast Policy Inference

## Motivation

```text
Diffusion:   noise → step → step → ... → action
Consistency: noise ─────────────────────→ action   (1–few steps)
```

The engineering question that matters for closed-loop control: **how much inference latency can be removed before action quality degrades?**

## Representative Work

- Lu et al., *ManiCM* — https://arxiv.org/abs/2406.01586
- Zhang et al., *FlowPolicy*, AAAI 2025 — https://ojs.aaai.org/index.php/AAAI/article/view/33617
- Yan et al., *ManiFlow*, CoRL 2025 — https://arxiv.org/abs/2509.01819
