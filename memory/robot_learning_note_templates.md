# Robot-Learning Note Templates

Templates used by `projects/learning_based_manipulation_project.md`. Paper notes and experiment records belong under `projects/` or `complement/`; session logs belong under `complement/`.

## Paper-Reading Template

```markdown
# Paper: <title>

## 1. Problem — what manipulation problem is solved?
## 2. Observation — modalities, horizon H_o, encoder, frame, rate
## 3. Action — representation, dimension D_a, frame, rate, limits
## 4. Temporal structure — H_p, H_a, replanning frequency
## 5. Policy distribution — deterministic / Gaussian / diffusion / flow / autoregressive
## 6. Training objective
## 7. Inference — sampler, step count, measured latency
## 8. Robot interface — what consumes the action, what enforces safety
## 9. Dataset — source, size, teleop method, task variety
## 10. Generalization — what varies at test time
## 11. Failure modes
## 12. Contribution — what is genuinely new vs inherited
## 13. My control/planning interpretation
```

## Experiment Template

```markdown
# Experiment: <name>

## Hypothesis
## Independent variable
## Controlled variables
## Metrics — success rate, inference latency, smoothness, disturbance recovery
## Configuration — horizons, steps, seeds, hardware
## Results
## Interpretation
## Unexpected behavior
## Next experiment
```

## Session Log Template

```markdown
# YYYY-MM-DD

## Topic
## What I understood
## Equations I can derive
## What is still unclear
## Code completed
## Experiment completed
## Important result
## Questions for next session
## Next action
```
