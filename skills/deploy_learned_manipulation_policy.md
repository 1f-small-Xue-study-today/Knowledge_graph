# Skill: Deploy a Learned Manipulation Policy on a Real Robot

## Purpose

Wrap a learned action-chunk policy in a conventional multi-rate control stack with a safety layer. This phase should lean hard on existing control and planning knowledge.

## Inputs

- Trained policy producing \(A\in\mathbb R^{H_p\times D_a}\).
- Robot servo/impedance/position controller and its command interface.
- Camera and proprioception streams with known rates and latencies.

## Step 1 — Choose the Action Space

Joint position \(q^d_t\) · joint delta \(\Delta q_t\) · joint velocity \(\dot q^d_t\) · EEF pose delta \([\Delta p_t,\Delta\phi_t,g_t]^T\) · torque \(\tau_t\).

For a first real-robot experiment prefer a higher-level position or pose command; go to torque only if the research question requires it.

## Step 2 — Preserve the Multi-Rate Stack

```text
Camera / Proprioception
   │ ~10–30 Hz
Learned policy  ──action chunk──▶ Reference / trajectory adapter
                                     │ 100–1000 Hz
                                  Servo / impedance / position controller
                                     │ kHz–tens of kHz
                                  Current / torque control ─▶ robot
```

Never demand that a diffusion model run at motor-control frequency; the adapter absorbs the rate mismatch.

## Step 3 — Safety Layer

Conceptually \(a_t^{\mathrm{policy}}\rightarrow\Pi_{\mathcal C}(a_t)\rightarrow a_t^{\mathrm{safe}}\), a projection onto an admissible command set:

- joint position, velocity, acceleration limits
- workspace bounding box, EEF orientation limits
- action-delta clipping and trajectory smoothing
- watchdog, stale-observation detection, command timeout
- emergency stop, optional collision checking

## Validation

The safety layer is exercised with deliberately invalid policy outputs before the policy is ever trusted, and the stack degrades safely on dropped observations.
