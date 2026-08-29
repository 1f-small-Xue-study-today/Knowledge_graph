> **Archived source draft.** This is the original unstructured roadmap dump, kept for reference. The working plan lives in `projects/learning_based_manipulation_project.md`, the topic/skill notes it links, and `plan/2026/`.

# Learning-Based Robot Manipulation — Engineering Roadmap

> **Primary track:** Imitation Learning → Action Chunking → Diffusion Models → Diffusion Policy → Real-Robot Deployment  
> **Secondary track:** 3D policies → Flow Matching / Consistency Models → Vision-Language-Action (VLA) models  
> **Target background:** robotics, classical control, trajectory/path planning, whole-body planning  
> **Learning style:** derive → implement → reproduce → compare → deploy  
> **Status convention:** `[ ]` not started · `[-]` in progress · `[x]` completed

---

## 0. Objective

The goal is **not** to become a general generative-model researcher.

The goal is to reach the point where I can:

1. Read a modern robot-manipulation policy paper and identify:
   - observation representation,
   - action representation,
   - policy distribution,
   - temporal horizon,
   - training objective,
   - inference procedure,
   - low-level control interface,
   - dataset assumptions,
   - deployment frequency and latency constraints.

2. Understand mathematically why Diffusion Policy works:
   \[
   A_{t:t+H} \sim p_\theta(A_{t:t+H}\mid O_{t-T_o+1:t})
   \]

3. Reproduce a small Diffusion Policy experiment from scratch or from an official implementation.

4. Compare Diffusion Policy against at least one simpler baseline such as:
   - deterministic behavior cloning,
   - Gaussian behavior cloning,
   - ACT.

5. Deploy a learned policy above a conventional robot controller:
   \[
   \text{learned policy}
   \rightarrow
   \text{EEF/joint reference}
   \rightarrow
   \text{servo controller}
   \rightarrow
   \text{motor control}
   \]

6. Understand the major directions after Diffusion Policy:
   - 3D observation representations,
   - Transformer/DiT action models,
   - consistency models,
   - flow matching,
   - robot foundation models / VLAs.

---

# 1. The Mental Model to Preserve

My existing robotics stack is approximately:

\[
\text{Perception}
\rightarrow
\text{State Estimation}
\rightarrow
\text{Planning}
\rightarrow
\text{Trajectory}
\rightarrow
\text{Feedback Control}
\rightarrow
\text{Actuation}
\]

Learning-based manipulation often replaces or merges part of the **perception → planning → reference generation** stack:

\[
\text{Images + Proprioception + Task}
\rightarrow
\pi_\theta
\rightarrow
\text{Action Chunk}
\rightarrow
\text{Low-Level Controller}
\]

The first conceptual transition is therefore:

### Classical formulation

\[
A^\star
=
\arg\min_A J(A)
\]

subject to a model and constraints.

### Learned generative formulation

\[
A
\sim
p_\theta(A\mid O)
\]

where the distribution is learned from demonstrations.

This distinction should remain explicit throughout the roadmap.

---

# 2. Recommended Learning Order

```text
Behavior Cloning
      ↓
Why deterministic regression fails
      ↓
Probability distributions over actions
      ↓
Action chunks / temporal policies
      ↓
Diffusion fundamentals
      ↓
Conditional diffusion
      ↓
Diffusion Policy
      ↓
Push-T reproduction
      ↓
Vision-based manipulation
      ↓
Real-time deployment architecture
      ↓
3D Diffusion Policy
      ↓
Flow Matching / Consistency
      ↓
VLA / Foundation Policies
```

Do **not** begin with a large VLA.

A large VLA introduces too many concepts simultaneously:

- visual representation learning,
- language conditioning,
- Transformers,
- large-scale pretraining,
- heterogeneous robot datasets,
- action tokenization or continuous action heads,
- generative action decoding,
- embodiment transfer.

Diffusion Policy is a much cleaner entry point because the relationship between observation, action trajectory, probability distribution, and receding-horizon execution remains visible.

---

# 3. Phase A — Imitation Learning Foundations

**Expected effort:** 4–6 focused hours

## A1. Behavior Cloning

### Learn

- [ ] What constitutes a demonstration dataset:
  \[
  \mathcal D = \{\tau_i\}_{i=1}^{N}
  \]
  with
  \[
  \tau_i = (o_0,a_0,o_1,a_1,\ldots)
  \]

- [ ] Deterministic policy:
  \[
  \hat a_t = \pi_\theta(o_t)
  \]

- [ ] MSE objective:
  \[
  \mathcal L_{\mathrm{BC}}
  =
  \mathbb E_{(o,a)\sim\mathcal D}
  \left[
  \|a-\pi_\theta(o)\|_2^2
  \right]
  \]

- [ ] Why MSE corresponds to a Gaussian likelihood assumption.

- [ ] Covariate shift / compounding error:
  training observations come from the expert distribution, while rollout observations come from the learned policy distribution.

### Critical question

Why does

\[
a = \mathbb E[a\mid o]
\]

become a bad control command when \(p(a\mid o)\) is multimodal?

### Implementation exercise

Build a toy 2-D dataset with two valid modes:

\[
a \approx [-1,1]^T
\quad \text{or} \quad
a \approx [1,1]^T
\]

for approximately the same observation.

Train a deterministic MLP with MSE.

Observe that it tends toward the average:

\[
a \approx [0,1]^T
\]

which can represent an invalid behavior.

### Exit criterion

I can clearly explain:

> **Why robot imitation learning should sometimes model a distribution over actions rather than one deterministic action.**

---

## A2. Probabilistic Policies

### Learn

- [ ] Conditional density:
  \[
  p(a\mid o)
  \]

- [ ] Gaussian policy:
  \[
  \pi_\theta(a\mid o)
  =
  \mathcal N(\mu_\theta(o),\Sigma_\theta(o))
  \]

- [ ] Negative log-likelihood.

- [ ] Difference between:
  - epistemic uncertainty,
  - stochasticity,
  - genuinely multimodal expert behavior.

- [ ] Why a single Gaussian is still insufficient for strongly multimodal manipulation.

### Optional concepts

Only learn these at a high level initially:

- Gaussian Mixture Models
- Conditional VAE
- autoregressive policies
- energy-based policies

The goal is to understand **what problem diffusion is solving**, not to master every generative model.

---

# 4. Phase B — Temporal Policies and Action Chunking

**Expected effort:** 3–5 hours

Before diffusion, understand why modern manipulation policies often output a sequence:

\[
A_t =
[a_t,a_{t+1},\ldots,a_{t+H-1}]
\]

rather than only \(a_t\).

## B1. Action Chunking

### Learn

- [ ] Action horizon \(H_a\)
- [ ] Prediction horizon \(H_p\)
- [ ] Observation horizon \(H_o\)
- [ ] Temporal correlation
- [ ] Receding-horizon execution
- [ ] Why chunking reduces effective decision horizon
- [ ] Why chunking can smooth behavior

### Connect to MPC

Classical MPC:

\[
U^\star_{t:t+H}
=
\arg\min_U J(x_t,U)
\]

then execute the first portion.

Chunked learned policy:

\[
A_{t:t+H}
\sim
p_\theta(A\mid O_t)
\]

then execute the first portion.

The structural similarity is useful, but do not confuse sampling from a learned distribution with solving an online constrained optimization problem.

---

## B2. Read ACT as a Baseline

**Paper:** *Learning Fine-Grained Bimanual Manipulation with Low-Cost Hardware* — Zhao et al., 2023.

ACT is useful because it isolates the importance of:

- action chunks,
- Transformer sequence modeling,
- imitation learning,
- temporal aggregation,

without requiring diffusion.

### Questions to answer

- [ ] What is ACT predicting?
- [ ] What is the input observation?
- [ ] How long is the action chunk?
- [ ] Why does chunking help with compounding error?
- [ ] How does ACT differ from Diffusion Policy?
- [ ] Which method has the simpler inference path?

### Exit criterion

I can distinguish:

```text
single-step BC
vs
action-chunk BC
vs
generative action-chunk policy
```

---

# 5. Phase C — Diffusion Fundamentals

**Expected effort:** 8–12 focused hours

This is the mathematical core.

Do not use robot images initially. Use a 1-D or 2-D distribution.

---

## C1. Forward Diffusion

Start from clean data:

\[
x_0 \sim q(x)
\]

Define:

\[
q(x_k\mid x_{k-1})
=
\mathcal N
\left(
\sqrt{\alpha_k}x_{k-1},
(1-\alpha_k)I
\right)
\]

with:

\[
\alpha_k=1-\beta_k
\]

and

\[
\bar\alpha_k
=
\prod_{i=1}^{k}\alpha_i
\]

Derive:

\[
\boxed{
x_k
=
\sqrt{\bar\alpha_k}x_0
+
\sqrt{1-\bar\alpha_k}\epsilon
}
\]

where

\[
\epsilon\sim\mathcal N(0,I)
\]

### Tasks

- [ ] Derive the closed-form marginal \(q(x_k\mid x_0)\).
- [ ] Plot samples for increasing \(k\).
- [ ] Understand the role of the noise schedule \(\beta_k\).
- [ ] Understand why sufficiently corrupted \(x_K\) approaches a simple Gaussian.

---

## C2. Reverse Process

Learn the model:

\[
p_\theta(x_{k-1}\mid x_k)
\]

and the common noise-prediction parameterization:

\[
\epsilon_\theta(x_k,k)
\]

with training objective approximately:

\[
\boxed{
\mathcal L
=
\mathbb E
\left[
\|\epsilon-\epsilon_\theta(x_k,k)\|_2^2
\right]
}
\]

### Required understanding

- [ ] Why predicting noise is enough to estimate the denoising direction.
- [ ] Why one network can handle many noise levels when conditioned on timestep \(k\).
- [ ] Difference between training and sampling.
- [ ] Why inference starts from random noise.

---

## C3. Score Interpretation

Understand:

\[
s_\theta(x,k)
\approx
\nabla_x\log p_k(x)
\]

Interpretation:

> The score gives a local vector field pointing toward increasing probability density.

Connect conceptually to optimization:

\[
-\nabla J(x)
\]

but retain the difference:

- \(-\nabla J\): descent direction of a designed objective;
- \(\nabla\log p(x)\): ascent direction of a learned log-density.

### Exit criterion

Without notes, I should be able to explain:

1. why noise is added during training,
2. what the neural network predicts,
3. how generation starts from noise,
4. why repeated denoising can recover samples from a complicated distribution.

---

## C4. Minimal Coding Exercise

Implement a tiny diffusion model for a synthetic 2-D distribution:

```text
two moons
or
mixture of 4–8 Gaussians
```

Required outputs:

- [ ] clean dataset plot
- [ ] noisy distribution at several diffusion steps
- [ ] training-loss curve
- [ ] generated samples
- [ ] denoising trajectories
- [ ] score/vector-field visualization if practical

**Do this before touching the full robotics repository.**

---

# 6. Phase D — Conditional Diffusion

**Expected effort:** 3–4 hours

Robot policy requires:

\[
p(A\mid O)
\]

rather than unconditional:

\[
p(A)
\]

Study:

\[
\epsilon_\theta(A_k,k,c)
\]

where the conditioning variable \(c\) can contain:

- images,
- proprioception,
- task instruction,
- object state,
- goal state.

### Toy experiment

Create a two-context dataset:

```text
condition 0 → trajectories going left
condition 1 → trajectories going right
```

Train one conditional diffusion model.

### Exit criterion

I understand that **Diffusion Policy is primarily conditional diffusion in robot action space**.

---

# 7. Phase E — Diffusion Policy Proper

**Expected effort:** 8–12 hours

**Core paper:**  
*Diffusion Policy: Visuomotor Policy Learning via Action Diffusion* — Chi et al.

Read the paper in three passes.

---

## Pass 1 — System-Level Understanding

Do not inspect every equation.

Answer:

- [ ] What are the observations?
- [ ] What are the actions?
- [ ] What distribution is learned?
- [ ] Why are action sequences generated?
- [ ] How is the generated trajectory executed?
- [ ] How frequently is the policy replanned?
- [ ] Where does classical robot control remain?

Target abstraction:

\[
O_{t-H_o+1:t}
\xrightarrow{\text{encoder}}
z_t
\]

\[
A_K\sim\mathcal N(0,I)
\]

\[
A_K
\xrightarrow[\text{conditioned on }z_t]{\text{iterative denoising}}
A_0
\]

\[
A_0[0:H_a]
\rightarrow
\text{robot controller}
\]

---

## Pass 2 — Mathematical Understanding

Study:

- [ ] forward diffusion in action space,
- [ ] conditional denoising network,
- [ ] noise prediction objective,
- [ ] score interpretation,
- [ ] inference sampler,
- [ ] observation horizon,
- [ ] action horizon,
- [ ] prediction horizon.

Write down tensor dimensions explicitly.

Example:

\[
O
\in
\mathbb R^{H_o\times D_o}
\]

\[
A
\in
\mathbb R^{H_p\times D_a}
\]

For image policies:

\[
I
\in
\mathbb R^{H_o\times C\times H\times W}
\]

---

## Pass 3 — Engineering Understanding

Inspect the official implementation and answer:

- [ ] How are trajectories normalized?
- [ ] How is a sample window extracted from an episode?
- [ ] How are episode boundaries handled?
- [ ] Which scheduler is used?
- [ ] How many training diffusion steps?
- [ ] How many inference steps?
- [ ] What is the denoising-network architecture?
- [ ] How is image conditioning injected?
- [ ] How are actions queued and executed?
- [ ] What happens when action/observation rates differ?

---

# 8. Phase F — First Reproduction: Push-T

**Expected effort:** 1–3 days of engineering work

Push-T is the recommended first reproduction because it separates the learning problem from full robot hardware complexity.

## F1. Low-Dimensional Version

Start with state observations.

### Goals

- [ ] Download/run an existing Push-T dataset.
- [ ] Inspect one trajectory numerically.
- [ ] Plot states and actions.
- [ ] Verify normalization.
- [ ] Train or run a pretrained low-dimensional Diffusion Policy.
- [ ] Visualize generated action chunks.
- [ ] Measure rollout success rate.
- [ ] Change action horizon.
- [ ] Change prediction horizon.
- [ ] Change number of denoising steps.

### Required experiment table

| Experiment | \(H_o\) | \(H_p\) | \(H_a\) | Diffusion steps | Success | Inference latency |
|---|---:|---:|---:|---:|---:|---:|
| baseline | | | | | | |
| short horizon | | | | | | |
| long horizon | | | | | | |
| fewer denoise steps | | | | | | |

The goal is not only to obtain success.  
The goal is to establish intuition about **temporal horizon vs latency vs robustness**.

---

## F2. Vision Version

Only after the low-dimensional version works:

\[
I_{t-H_o+1:t}
\rightarrow
\text{vision encoder}
\rightarrow
z
\rightarrow
\text{diffusion action decoder}
\]

### Learn

- [ ] image augmentation,
- [ ] multiple camera views,
- [ ] feature encoder,
- [ ] proprioceptive fusion,
- [ ] latency introduced by visual processing,
- [ ] train/test visual distribution shift.

---

# 9. Phase G — Compare Against ACT

**Expected effort:** 4–8 hours after both implementations are available

Run the same or similar manipulation setting with:

1. deterministic BC,
2. ACT,
3. Diffusion Policy.

Compare:

| Property | BC | ACT | Diffusion Policy |
|---|---|---|---|
| outputs action chunk | optional | yes | yes |
| multimodal output | weak | generative/latent | strong generative modeling |
| inference passes | ~1 | ~1 | multiple |
| temporal modeling | limited | strong | strong |
| implementation complexity | low | medium | medium/high |
| real-time cost | low | low/moderate | moderate/high |

### Key analysis

Do not ask only:

> Which policy has higher success?

Also ask:

\[
\text{Where is diffusion actually buying something?}
\]

Potential answer dimensions:

- multimodal task?
- long temporal correlation?
- precision?
- disturbance recovery?
- dataset heterogeneity?
- contact behavior?

This comparison prevents treating diffusion as a default solution to every manipulation problem.

---

# 10. Phase H — Robot Deployment Architecture

**Expected effort:** highly platform-dependent

This phase should use existing robotics/control knowledge aggressively.

## H1. Decide the Action Space

Possible action representations:

### Joint position

\[
a_t=q_t^d
\]

### Joint delta

\[
a_t=\Delta q_t
\]

### Joint velocity

\[
a_t=\dot q_t^d
\]

### End-effector pose delta

\[
a_t=
\begin{bmatrix}
\Delta p_t\\
\Delta \phi_t\\
g_t
\end{bmatrix}
\]

### Torque

\[
a_t=\tau_t
\]

For a first real-robot manipulation experiment, prefer a **higher-level position or pose command** over direct torque learning unless the research question specifically requires torque-level behavior.

---

## H2. Preserve a Multi-Rate Control Stack

Recommended architecture:

```text
Camera / Proprioception
       │
       │  10–30 Hz approximately
       ▼
Learned Manipulation Policy
       │
       │  action chunk
       ▼
Reference / Trajectory Adapter
       │
       │  100–1000 Hz
       ▼
Robot Servo / Impedance / Position Controller
       │
       ▼
Motor Current / Torque Control
       │
       │  kHz–tens of kHz
       ▼
Robot
```

The exact rates depend on hardware.

Do not demand that a diffusion model operate at motor-control frequency.

---

## H3. Safety Layer

Before real deployment, add:

- [ ] joint-position limits,
- [ ] joint-velocity limits,
- [ ] acceleration limits,
- [ ] workspace bounding box,
- [ ] EEF orientation limits if needed,
- [ ] action-delta clipping,
- [ ] watchdog,
- [ ] stale-observation detection,
- [ ] command timeout,
- [ ] emergency stop,
- [ ] optional collision checking,
- [ ] optional trajectory smoothing.

Conceptually:

\[
a_t^{\mathrm{policy}}
\rightarrow
\Pi_{\mathcal C}(a_t)
\rightarrow
a_t^{\mathrm{safe}}
\]

where \(\Pi_{\mathcal C}\) represents a safety projection/filter onto an admissible command set.

---

# 11. Phase I — Build a Small Real-Robot Dataset

Avoid starting with a complicated long-horizon task.

Recommended progression:

### Task 1 — planar reach

```text
move EEF to visually specified object
```

### Task 2 — pick

```text
approach → grasp → lift
```

### Task 3 — pick and place

```text
grasp object → transport → place
```

### Task 4 — multimodal obstacle manipulation

Create a situation where two strategies are genuinely valid:

```text
go left around obstacle
or
go right around obstacle
```

This is useful because it tests the core multimodality argument behind generative policies.

---

# 12. Phase J — 3D Diffusion Policy

**Paper:**  
*3D Diffusion Policy: Generalizable Visuomotor Policy Learning via Simple 3D Representations* — Ze et al., 2024.

Study this **after** the original Diffusion Policy.

## Questions

- [ ] Why may RGB-only policies struggle with geometric generalization?
- [ ] How is a point cloud represented?
- [ ] What is the point encoder?
- [ ] Does diffusion itself change, or mainly the observation representation?
- [ ] How does 3D representation affect viewpoint generalization?
- [ ] What are the compute implications?

### Key abstraction

Original:

\[
\text{RGB}
\rightarrow
z
\rightarrow
p_\theta(A\mid z)
\]

DP3:

\[
\text{Point Cloud}
\rightarrow
z_{3D}
\rightarrow
p_\theta(A\mid z_{3D})
\]

The important lesson:

> Separate **action-generation method** from **observation representation**.

---

# 13. Phase K — Flow Matching and Consistency Models

This should come after diffusion is mathematically comfortable.

Modern robot policies increasingly use flow-based formulations to reduce the cost of iterative diffusion inference.

## K1. Conditional Flow Matching

Study the idea:

\[
\frac{dx}{dt}
=
v_\theta(x,t\mid o)
\]

Instead of learning a stochastic denoising chain, learn a vector field transporting a simple distribution toward the data distribution.

Connect this to a continuous-time dynamical system.

This representation should be intuitive from control:

\[
\dot x=f_\theta(x,t,o)
\]

Inference becomes numerical integration through the learned field.

### Questions

- [ ] What distribution is the flow starting from?
- [ ] What is the target distribution?
- [ ] What velocity field is learned?
- [ ] Euler vs higher-order integration?
- [ ] How many integration steps are required?
- [ ] Why can the path be straighter than diffusion sampling?

---

## K2. Consistency Models

Understand the motivation:

```text
Diffusion:
noise → step → step → step → ... → action

Consistency:
noise ───────────────────────→ action
                 1–few steps
```

Read representative manipulation work such as:

- ManiCM
- FlowPolicy
- ManiFlow

Focus on the engineering question:

\[
\boxed{
\text{How much inference latency can be removed without losing action quality?}
}
\]

This is especially relevant for closed-loop robot control.

---

# 14. Phase L — Robot Foundation Models / VLAs

Only enter this phase after understanding a small generative policy.

Representative models/papers:

- Octo
- OpenVLA
- RDT-1B
- \(\pi_0\)
- current LeRobot VLA implementations

## New abstraction

Instead of:

\[
p(A\mid I,q)
\]

we now commonly have:

\[
p(A\mid I,q,\text{language})
\]

with large-scale pretraining over many robots/tasks.

### Study dimensions

- [ ] Vision encoder
- [ ] Language encoder / VLM backbone
- [ ] Proprioceptive input
- [ ] Action representation
- [ ] Action chunking
- [ ] Diffusion / flow / discrete action decoder
- [ ] Cross-embodiment normalization
- [ ] Fine-tuning
- [ ] Parameter-efficient fine-tuning
- [ ] dataset scaling
- [ ] robot morphology differences

### Important conceptual separation

A **VLA** describes the conditioning/modalities and often the scale of the policy.

It does **not** uniquely specify how actions are generated.

A VLA can use:

- autoregressive action tokens,
- diffusion,
- flow matching,
- other continuous action heads.

For example, \(\pi_0\) uses a flow-based continuous-action formulation, while RDT uses diffusion.

---

# 15. Suggested Paper Order

## Tier 1 — Mandatory

1. **Diffusion Policy: Visuomotor Policy Learning via Action Diffusion**  
   Chi et al., RSS 2023 / IJRR 2024  
   Project: https://diffusion-policy.cs.columbia.edu/  
   arXiv: https://arxiv.org/abs/2303.04137

2. **Learning Fine-Grained Bimanual Manipulation with Low-Cost Hardware**  
   Zhao et al., 2023 — ACT  
   arXiv: https://arxiv.org/abs/2304.13705

3. **3D Diffusion Policy: Generalizable Visuomotor Policy Learning via Simple 3D Representations**  
   Ze et al., 2024  
   arXiv: https://arxiv.org/abs/2403.03954

---

## Tier 2 — Modern Generative Policy Evolution

4. **Learning Robotic Manipulation Policies from Point Clouds with Conditional Flow Matching**  
   Chisari et al., CoRL/PMLR 2025

5. **FlowPolicy: Enabling Fast and Robust 3D Flow-Based Policy via Consistency Flow Matching for Robot Manipulation**  
   Zhang et al., AAAI 2025

6. **ManiCM: Real-time 3D Diffusion Policy via Consistency Model for Robotic Manipulation**  
   Lu et al., 2024  
   arXiv: https://arxiv.org/abs/2406.01586

7. **ManiFlow: A General Robot Manipulation Policy via Consistency Flow Training**  
   Yan et al., CoRL 2025  
   arXiv: https://arxiv.org/abs/2509.01819

---

## Tier 3 — Generalist / Foundation Policies

8. **Octo: An Open-Source Generalist Robot Policy**  
   2024  
   arXiv: https://arxiv.org/abs/2405.12213

9. **OpenVLA: An Open-Source Vision-Language-Action Model**  
   Kim et al., 2024  
   arXiv: https://arxiv.org/abs/2406.09246

10. **RDT-1B: a Diffusion Foundation Model for Bimanual Manipulation**  
    Liu et al., 2024  
    arXiv: https://arxiv.org/abs/2410.07864

11. **\(\pi_0\): A Vision-Language-Action Flow Model for General Robot Control**  
    Black et al., 2024  
    arXiv: https://arxiv.org/abs/2410.24164

---

# 16. Recommended Software Path

## Stage 1 — Pure PyTorch

Implement the toy diffusion examples directly in PyTorch.

Reason:

> Framework abstraction is undesirable while learning the mathematics.

---

## Stage 2 — Official Diffusion Policy Repository

Use the original implementation to reproduce Push-T and inspect the exact data/inference pipeline.

Official project:

https://diffusion-policy.cs.columbia.edu/

---

## Stage 3 — LeRobot

After the mechanics are understood, use LeRobot to study a more standardized modern robot-learning software stack:

https://huggingface.co/docs/lerobot/

Useful topics:

- datasets,
- policy APIs,
- ACT,
- modern DiT policies,
- deployment,
- bringing custom hardware,
- adding a custom policy.

The purpose is to understand reusable robot-learning infrastructure rather than becoming dependent on one research repository.

---

# 17. Recommended Local Repository Structure

```text
robot_manipulation_learning/
│
├── README.md
├── roadmap.md
│
├── 00_notes/
│   ├── terminology.md
│   ├── paper_template.md
│   └── experiment_template.md
│
├── 01_behavior_cloning/
│   ├── notes.md
│   └── toy_multimodal_bc.py
│
├── 02_action_chunking/
│   ├── act_notes.md
│   └── comparison.md
│
├── 03_diffusion_fundamentals/
│   ├── derivation.md
│   ├── toy_diffusion_2d.py
│   └── figures/
│
├── 04_diffusion_policy/
│   ├── paper_notes.md
│   ├── architecture.md
│   └── code_walkthrough.md
│
├── 05_pusht/
│   ├── experiments.md
│   ├── configs/
│   └── figures/
│
├── 06_real_robot/
│   ├── interface.md
│   ├── action_space.md
│   ├── safety.md
│   ├── dataset.md
│   └── experiments.md
│
├── 07_3d_policy/
│   └── dp3_notes.md
│
├── 08_flow_matching/
│   ├── derivation.md
│   └── paper_notes.md
│
├── 09_vla/
│   ├── octo.md
│   ├── openvla.md
│   ├── rdt.md
│   └── pi0.md
│
└── progress/
    ├── weekly_log.md
    └── questions.md
```

---

# 18. Paper-Reading Template

Use this template for every manipulation-learning paper.

```markdown
# Paper

## 1. Problem

What manipulation problem is being solved?

## 2. Observation

- RGB?
- depth?
- point cloud?
- proprioception?
- language?
- observation history?

## 3. Action

- joint position?
- EEF delta pose?
- joint velocity?
- torque?
- gripper?
- action dimension?

## 4. Temporal Structure

- single action or chunk?
- observation horizon?
- prediction horizon?
- execution horizon?
- replanning frequency?

## 5. Policy Distribution

What is modeled?

p(a|o)?
p(A|O)?
autoregressive?
Gaussian?
VAE?
diffusion?
flow?

## 6. Training Objective

Write the actual loss mathematically.

## 7. Inference

What exactly happens during one policy query?

How many network evaluations are required?

## 8. Robot Interface

What controller receives the policy output?

At what frequency?

## 9. Dataset

- demonstrations?
- teleoperation?
- number of episodes?
- simulation or real?
- single or multi-task?

## 10. Generalization

What changes at test time?

- object?
- pose?
- viewpoint?
- background?
- task?
- robot embodiment?

## 11. Failure Modes

What does the method fail on?

## 12. Contribution

What is genuinely new?

## 13. My Control/Planning Interpretation

How would I formulate the same problem using classical robotics?

What component has learning replaced?
```

---

# 19. Experiment Template

```markdown
# Experiment

## Hypothesis

Example:
Reducing diffusion inference steps from 16 to 4 will reduce latency
substantially but may reduce trajectory quality.

## Independent Variable

...

## Controlled Variables

...

## Metrics

- success rate
- trajectory smoothness
- inference latency
- control frequency
- action variance
- collision count
- completion time

## Configuration

...

## Results

...

## Interpretation

...

## Unexpected Behavior

...

## Next Experiment

...
```

---

# 20. Weekly / Session Learning Log

```markdown
# YYYY-MM-DD

## Topic

## What I understood

## Equations I can derive

## What is still unclear

## Code completed

## Experiment completed

## Important result

## Questions for next learning session

## Next action
```

The `questions.md` file should be treated as an active queue for discussions.

---

# 21. Progress Checklist

## Level 0 — Vocabulary

- [ ] I understand BC.
- [ ] I understand action chunking.
- [ ] I understand multimodal action distributions.
- [ ] I understand conditional generative policies.
- [ ] I understand observation/action/prediction horizons.

---

## Level 1 — Diffusion Mathematics

- [ ] I can derive \(q(x_k\mid x_0)\).
- [ ] I understand the noise schedule.
- [ ] I understand epsilon prediction.
- [ ] I understand training vs inference.
- [ ] I understand the score interpretation.
- [ ] I implemented 2-D diffusion.

---

## Level 2 — Diffusion Policy

- [ ] I read Diffusion Policy once.
- [ ] I read it a second time mathematically.
- [ ] I inspected the implementation.
- [ ] I understand observation/action horizons.
- [ ] I understand receding-horizon execution.
- [ ] I can draw the complete architecture without notes.

---

## Level 3 — Reproduction

- [ ] Push-T environment works.
- [ ] Dataset visualized.
- [ ] Low-dimensional policy reproduced.
- [ ] Vision policy reproduced.
- [ ] Inference latency measured.
- [ ] Horizon ablation completed.
- [ ] Denoising-step ablation completed.

---

## Level 4 — Comparative Understanding

- [ ] I understand ACT.
- [ ] I compared ACT and Diffusion Policy.
- [ ] I know when deterministic BC is sufficient.
- [ ] I know when multimodality matters.
- [ ] I can explain the compute/quality tradeoff.

---

## Level 5 — Real Robot

- [ ] Robot observation API defined.
- [ ] Robot action API defined.
- [ ] Safety layer implemented.
- [ ] Teleoperation dataset recorded.
- [ ] Dataset replay visualized.
- [ ] Policy trained.
- [ ] Offline validation completed.
- [ ] Slow-speed deployment completed.
- [ ] Closed-loop deployment completed.
- [ ] Failure cases documented.

---

## Level 6 — Modern Methods

- [ ] Read DP3.
- [ ] Understand 3D observation encoding.
- [ ] Understand flow matching.
- [ ] Understand consistency models.
- [ ] Read one flow-policy paper deeply.
- [ ] Understand VLA architecture.
- [ ] Read \(\pi_0\), RDT, or another foundation policy deeply.

---

# 22. What Not to Learn Yet

Defer these unless a later problem specifically requires them:

- [ ] full stochastic differential equation theory,
- [ ] rigorous measure-theoretic probability,
- [ ] GAN theory,
- [ ] every VAE derivation,
- [ ] full reinforcement-learning curriculum,
- [ ] LLM/VLM pretraining internals,
- [ ] billion-parameter VLA training,
- [ ] direct torque-level end-to-end policy learning.

These can become relevant later, but they are not prerequisites for becoming productive with Diffusion Policy.

---

# 23. Questions That Should Drive the Learning Process

These are more important than memorizing architecture names.

## Representation

1. What information does the observation omit?
2. Does the policy need temporal observation history?
3. RGB vs depth vs point cloud?
4. Absolute vs delta actions?
5. Joint-space vs Cartesian action?

## Distribution

6. Is the expert behavior truly multimodal?
7. Is a deterministic action sufficient?
8. Does the model commit to one mode during rollout?
9. Is stochasticity useful or harmful for this task?

## Temporal Structure

10. How large should \(H_p\) be?
11. How much of the predicted chunk should be executed?
12. How often should perception refresh?
13. What happens if inference takes longer than one control period?

## Control

14. Which layer remains classical control?
15. How are commands interpolated?
16. How do we enforce velocity/acceleration limits?
17. What happens during contact?
18. Should the policy output target pose or impedance parameters?

## Data

19. How much demonstration data is actually required?
20. Are demonstrations consistent?
21. Does operator style create artificial multimodality?
22. What distribution shift occurs at deployment?

## Evaluation

23. Is task success enough?
24. What is inference latency?
25. What is disturbance-recovery behavior?
26. What is the failure distribution?
27. Does the policy generalize outside the demonstration manifold?

---

# 24. First Concrete Milestone

Do not define the first milestone as:

> “Finish reading Diffusion Policy.”

Define it as:

> **I can implement and explain a conditional 2-D diffusion model, then map every variable in that implementation onto a robot action trajectory.**

The mapping should be explicit:

| Toy diffusion | Robot manipulation |
|---|---|
| \(x_0\) | clean action chunk \(A_0\) |
| \(x_k\) | noisy action chunk \(A_k\) |
| condition \(c\) | observation \(O_t\) |
| denoiser | action denoising network |
| generated sample | candidate robot action trajectory |
| repeated sampling | repeated closed-loop policy query |

Once this is solid, Diffusion Policy becomes much easier to read.

---

# 25. Suggested First Five Learning Sessions

## Session 1 — Behavior Cloning and Multimodality

**Goal:** understand why generative policies are needed.

Deliverable:

```text
01_behavior_cloning/notes.md
```

---

## Session 2 — Diffusion Forward Process

**Goal:** derive:

\[
x_k
=
\sqrt{\bar\alpha_k}x_0
+
\sqrt{1-\bar\alpha_k}\epsilon
\]

Deliverable:

```text
03_diffusion_fundamentals/derivation.md
```

---

## Session 3 — Reverse Process and Noise Prediction

**Goal:** understand exactly what the network learns.

Deliverable:

```text
03_diffusion_fundamentals/toy_diffusion_2d.py
```

---

## Session 4 — Conditional Diffusion → Robot Policy

**Goal:** convert:

\[
p(x)
\]

into:

\[
p(A\mid O)
\]

Deliverable:

```text
04_diffusion_policy/architecture.md
```

---

## Session 5 — Diffusion Policy Paper Pass 1

**Goal:** reconstruct the architecture without following implementation details.

Deliverable:

```text
04_diffusion_policy/paper_notes.md
```

After these five sessions, begin Push-T reproduction.

---

# 26. Longer-Term Capstone

A useful final project would be:

> **Vision-conditioned single-arm manipulation with a diffusion/flow action policy and conventional low-level control.**

Example:

```text
RGB-D camera
     │
     ▼
object / scene representation
     │
     ▼
conditional action policy
     │
     ▼
EEF SE(3) action chunk
     │
     ▼
safety + rate limiter
     │
     ▼
IK / operational-space controller
     │
     ▼
joint servo
     │
     ▼
robot
```

Evaluate:

1. deterministic BC,
2. ACT,
3. Diffusion Policy,
4. optionally flow matching.

Primary metrics:

\[
\text{task success}
\]

\[
\text{inference latency}
\]

\[
\text{trajectory smoothness}
\]

\[
\text{disturbance recovery}
\]

\[
\text{generalization}
\]

This gives a technically meaningful comparison rather than simply reproducing a neural-network benchmark.

---

# 27. Current Recommended Priority

```text
HIGH PRIORITY
│
├── Behavior cloning
├── Multimodal action distributions
├── Action chunks
├── DDPM fundamentals
├── Conditional diffusion
├── Diffusion Policy
├── Push-T reproduction
└── Real robot action/control interface
│
MEDIUM PRIORITY
│
├── ACT comparison
├── 3D Diffusion Policy
├── Flow Matching
└── Consistency Models
│
LATER
│
├── Octo
├── OpenVLA
├── RDT
├── π0
├── large-scale cross-embodiment training
└── RL fine-tuning of foundation policies
```

---

# 28. Definition of “Ready to Move Beyond Diffusion Policy”

Move to modern VLA / foundation-policy work only when all of the following are true:

- [ ] I can derive the diffusion forward equation.
- [ ] I can explain epsilon prediction.
- [ ] I can implement a toy conditional diffusion model.
- [ ] I understand action chunks.
- [ ] I understand Diffusion Policy training.
- [ ] I understand Diffusion Policy inference.
- [ ] I have run at least one manipulation reproduction.
- [ ] I understand the robot control interface.
- [ ] I can identify a concrete limitation of Diffusion Policy that motivates the next method.

At that point the next method should be selected by the limitation:

```text
Need lower latency?
    → flow matching / consistency

Need stronger geometric generalization?
    → 3D policy

Need many tasks / language?
    → VLA / generalist policy

Need higher task-level reasoning?
    → VLM/VLA hierarchy

Need performance beyond demonstrations?
    → RL / offline RL / policy improvement
```

---

# 29. Immediate Next Step

Start with:

## Topic

**Behavior Cloning → Multimodal Action Distribution**

### We should derive together

\[
\mathcal L_{\mathrm{MSE}}
=
\mathbb E[\|a-\pi(o)\|^2]
\]

and prove why the optimal deterministic predictor under this objective is:

\[
\boxed{
\pi^\star(o)=\mathbb E[a\mid o]
}
\]

Then use a two-mode manipulation example to show mathematically why the conditional mean can be an invalid robot action.

That result provides the cleanest mathematical motivation for Diffusion Policy.

---

# References / Starting Resources

- Chi et al., **Diffusion Policy: Visuomotor Policy Learning via Action Diffusion**  
  https://diffusion-policy.cs.columbia.edu/  
  https://arxiv.org/abs/2303.04137

- Zhao et al., **Learning Fine-Grained Bimanual Manipulation with Low-Cost Hardware (ACT)**  
  https://arxiv.org/abs/2304.13705

- Ze et al., **3D Diffusion Policy**  
  https://arxiv.org/abs/2403.03954

- Lu et al., **ManiCM**  
  https://arxiv.org/abs/2406.01586

- Chisari et al., **Learning Robotic Manipulation Policies from Point Clouds with Conditional Flow Matching**  
  https://proceedings.mlr.press/v270/chisari25a.html

- Zhang et al., **FlowPolicy**  
  https://ojs.aaai.org/index.php/AAAI/article/view/33617

- Yan et al., **ManiFlow**  
  https://arxiv.org/abs/2509.01819

- Octo Model Team, **Octo**  
  https://arxiv.org/abs/2405.12213

- Kim et al., **OpenVLA**  
  https://arxiv.org/abs/2406.09246

- Liu et al., **RDT-1B**  
  https://arxiv.org/abs/2410.07864

- Black et al., **π0**  
  https://arxiv.org/abs/2410.24164

- Hugging Face, **LeRobot Documentation**  
  https://huggingface.co/docs/lerobot/
