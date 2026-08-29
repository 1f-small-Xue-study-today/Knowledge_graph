# Project: Learning-Based Robot Manipulation

## Description

Reach the point of reading a modern manipulation-policy paper and identifying its observation representation, action representation, policy distribution, temporal horizon, training objective, inference procedure, low-level control interface, dataset assumptions, and deployment frequency/latency constraints — then reproducing one such policy and deploying it on real hardware behind a conventional control stack.

The goal is **not** to become a general generative-model researcher. Learning-based manipulation replaces part of the classical perception → planning → reference-generation stack:

```text
Images + Proprioception + Task  ──▶  π_θ  ──▶  Action Chunk  ──▶  Low-Level Controller
```

## Requirements

- Derive DDPM forward/reverse equations and implement a toy conditional diffusion model in pure PyTorch.
- Understand action chunking as receding-horizon execution of a learned distribution.
- Read Diffusion Policy in three passes: system, mathematics, implementation.
- Reproduce Push-T (state, then vision) and quantify horizon vs latency vs robustness.
- Compare BC, ACT, and Diffusion Policy on one fixed task.
- Define a real-robot action space, multi-rate stack, and safety projection.
- Collect a small demonstration dataset including one genuinely multimodal task.
- Extend to 3D policies, flow matching / consistency models, then VLAs.

## Ordered Milestones

| # | Phase | Deliverable | Notes | Status |
|---|---|---|---|---|
| 1 | A — Imitation learning foundations | toy multimodal BC demo | `topics/behavior_cloning.md` | [ ] |
| 2 | B — Action chunking + ACT read | ACT comparison note | `topics/action_chunking.md` | [ ] |
| 3 | C — Diffusion fundamentals | 2-D toy diffusion demo | `topics/diffusion_models.md`, `skills/implement_toy_diffusion_pytorch.md` | [ ] |
| 4 | D — Conditional diffusion | left/right conditional demo | `topics/conditional_diffusion.md` | [ ] |
| 5 | E — Diffusion Policy, 3 passes | paper + architecture notes | `topics/diffusion_policy.md` | [ ] |
| 6 | F — Push-T reproduction | experiment table | `skills/reproduce_diffusion_policy_pusht.md` | [ ] |
| 7 | G — BC / ACT / DP comparison | comparison report | `skills/compare_manipulation_policies.md` | [ ] |
| 8 | H — Deployment architecture | action space + safety layer | `skills/deploy_learned_manipulation_policy.md` | [ ] |
| 9 | I — Real-robot dataset | 4 tasks recorded | `skills/collect_robot_demonstration_dataset.md` | [ ] |
| 10 | J — 3D Diffusion Policy | DP3 notes | `topics/diffusion_policy_3d.md` | [ ] |
| 11 | K — Flow matching / consistency | derivation + paper notes | `topics/flow_matching.md`, `topics/consistency_models.md` | [ ] |
| 12 | L — VLA / foundation policies | model comparison notes | `topics/vision_language_action_models.md` | [ ] |

Status convention: `[ ]` not started · `[-]` in progress · `[x]` complete.

## First Concrete Milestone

Not "finish reading Diffusion Policy", but:

> **I can implement and explain a conditional 2-D diffusion model, then map every variable onto a robot action trajectory.**

## Gate — Ready to Move Beyond Diffusion Policy

- [ ] Derive the diffusion forward equation.
- [ ] Explain epsilon prediction.
- [ ] Implement a toy conditional diffusion model.
- [ ] Understand action chunks.
- [ ] Understand Diffusion Policy training and inference.
- [ ] Complete at least one manipulation reproduction.
- [ ] Understand the robot control interface.
- [ ] Name a concrete limitation of Diffusion Policy that motivates the next method.

Then select the next method by the limitation: lower latency → flow matching / consistency; geometric generalization → 3D policy; many tasks / language → VLA; higher-level reasoning → VLM/VLA hierarchy; performance beyond demonstrations → RL / offline RL.

## Deliberately Deferred

Large-scale cross-embodiment pretraining, RL fine-tuning of foundation policies, and mastering every generative model family (GMM, VAE, EBM, autoregressive policies) beyond a high-level understanding.

## Capstone

Vision-conditioned single-arm manipulation with a diffusion/flow action policy and conventional low-level control:

```text
RGB-D ─▶ scene representation ─▶ conditional action policy ─▶ EEF SE(3) action chunk
      ─▶ safety + rate limiter ─▶ IK / operational-space controller ─▶ joint servo ─▶ robot
```

Evaluate BC, ACT, Diffusion Policy, and optionally flow matching on task success, inference latency, trajectory smoothness, disturbance recovery, and generalization.

## Paper Order

**Tier 1 (mandatory):** Diffusion Policy (https://arxiv.org/abs/2303.04137) · ACT (https://arxiv.org/abs/2304.13705) · DP3 (https://arxiv.org/abs/2403.03954)

**Tier 2 (generative policy evolution):** Chisari et al. flow matching from point clouds (https://proceedings.mlr.press/v270/chisari25a.html) · FlowPolicy (https://ojs.aaai.org/index.php/AAAI/article/view/33617) · ManiCM (https://arxiv.org/abs/2406.01586) · ManiFlow (https://arxiv.org/abs/2509.01819)

**Tier 3 (generalist):** Octo (https://arxiv.org/abs/2405.12213) · OpenVLA (https://arxiv.org/abs/2406.09246) · RDT-1B (https://arxiv.org/abs/2410.07864) · π0 (https://arxiv.org/abs/2410.24164)

## Driving Questions

Kept open across the whole project — representation (what is in \(O\), what is in \(a\), what frame, what rate), distribution (is the task multimodal, does averaging break it), temporal structure (how long a chunk, how often to replan), control (what consumes the action, what enforces limits), data (how many demonstrations, how varied), evaluation (is success rate enough, what is the latency and the failure distribution).

## Note Templates

Paper-reading, experiment, and session-log templates: `memory/robot_learning_note_templates.md`.

## Source

Full original roadmap draft archived at `complement/robot_manipulation_roadmap_source.md`.
