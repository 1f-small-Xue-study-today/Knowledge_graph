# Skill: Implement a Toy Diffusion Model in PyTorch

## Purpose

Build a minimal unconditional then conditional diffusion model on a synthetic 2-D distribution, in pure PyTorch, before touching any robotics repository. Framework abstraction is undesirable while learning the mathematics.

## Inputs

- Synthetic dataset: two moons, or a mixture of 4–8 Gaussians.
- Noise schedule \(\beta_k\) and number of diffusion steps \(K\).
- Small MLP denoiser \(\epsilon_\theta(x_k,k)\), later \(\epsilon_\theta(x_k,k,c)\).

## Procedure

1. Sample the clean dataset and implement the closed-form forward step \(x_k=\sqrt{\bar\alpha_k}x_0+\sqrt{1-\bar\alpha_k}\epsilon\).
2. Train the denoiser on \(\mathcal L=\mathbb E\|\epsilon-\epsilon_\theta(x_k,k)\|^2\) with uniformly sampled \(k\).
3. Implement ancestral sampling from \(x_K\sim\mathcal N(0,I)\) and record the full denoising trajectory.
4. Add a discrete condition \(c\) (left/right trajectory dataset) and repeat, verifying the samples respect \(c\).
5. Map every variable to its robot counterpart: \(x_0\to A_0\), \(c\to O_t\), sample → candidate action chunk.

## Outputs

- `demo/diffusion_toy/scripts/` — training and sampling scripts.
- `demo/diffusion_toy/figures/` — clean dataset, noisy marginals at several \(k\), loss curve, generated samples, denoising trajectories, score/vector-field plot if practical.

## Validation

Generated samples cover all modes of the target distribution (no mode collapse, no mass between modes), conditional samples separate cleanly by \(c\), and the loss curve is stable.
