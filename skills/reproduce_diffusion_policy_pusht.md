# Skill: Reproduce Diffusion Policy on Push-T

## Purpose

Run the first full reproduction on Push-T, which separates the learning problem from robot-hardware complexity, and build intuition for temporal horizon vs latency vs robustness.

## Inputs

- Push-T dataset (state version first, image version second).
- Official Diffusion Policy implementation — https://diffusion-policy.cs.columbia.edu/
- GPU training environment.

## Procedure — Low-Dimensional First

1. Download and run the dataset; inspect one trajectory numerically and plot states and actions.
2. Verify normalization and sample-window extraction, including episode boundaries.
3. Train or load a low-dimensional policy; visualize generated action chunks.
4. Measure rollout success rate as the baseline.
5. Sweep the horizons and denoising steps and fill the experiment table.

| Experiment | \(H_o\) | \(H_p\) | \(H_a\) | Diffusion steps | Success | Inference latency |
|---|---:|---:|---:|---:|---:|---:|
| baseline | | | | | | |
| short horizon | | | | | | |
| long horizon | | | | | | |
| fewer denoise steps | | | | | | |

## Procedure — Vision Version

Only after the low-dimensional version works: \(I_{t-H_o+1:t}\to\) encoder \(\to z\to\) diffusion action decoder. Study image augmentation, multiple camera views, proprioceptive fusion, latency added by visual processing, and train/test visual distribution shift.

## Validation

Success rate reproduces the published order of magnitude, and each table row has a recorded latency and an interpretation of why performance moved.

## Notes

Software path: pure PyTorch (toy) → official Diffusion Policy repo (reproduction) → LeRobot (https://huggingface.co/docs/lerobot/) for standardized datasets, policy APIs, ACT, deployment, and custom hardware/policies.
