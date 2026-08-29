---
id: diffusion_policy_3d
type: topic
name: 3D Diffusion Policy (DP3)
level: advanced
status: not_started
prerequisites:
  - diffusion_policy
related:
  - ransac
last_updated: 2026-08-29
---

# 3D Diffusion Policy (DP3)

**Paper:** Ze et al., 2024 — https://arxiv.org/abs/2403.03954

## Key Lesson

Separate the **action-generation method** from the **observation representation**:

\[
\text{RGB}\rightarrow z\rightarrow p_\theta(A\mid z)
\qquad\text{vs}\qquad
\text{Point Cloud}\rightarrow z_{3D}\rightarrow p_\theta(A\mid z_{3D})
\]

The diffusion machinery is largely unchanged; the conditioning representation changes.

## Questions

- Why do RGB-only policies struggle with geometric generalization?
- How is the point cloud represented and encoded?
- How does 3D representation affect viewpoint generalization?
- What are the compute implications?
