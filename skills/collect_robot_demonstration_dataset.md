# Skill: Build a Small Real-Robot Demonstration Dataset

## Purpose

Collect the minimum dataset needed to test a learned policy on real hardware, progressing in difficulty rather than starting with a long-horizon task.

## Task Progression

1. **Planar reach** — move the EEF to a visually specified object.
2. **Pick** — approach, grasp, lift.
3. **Pick and place** — grasp, transport, place.
4. **Multimodal obstacle manipulation** — two genuinely valid strategies (around the obstacle left or right). This is the task that directly tests the multimodality argument behind generative policies.

## Procedure

1. Fix camera extrinsics, control rate, and action space before recording anything.
2. Record synchronized observation/action streams with timestamps; log episode boundaries explicitly.
3. Keep demonstration style consistent within a task, and deliberately varied for task 4.
4. Verify normalization statistics and replay a few episodes open-loop before training.

## Validation

An episode can be replayed and inspected numerically; the multimodal task shows two clearly separated action distributions for near-identical observations.
