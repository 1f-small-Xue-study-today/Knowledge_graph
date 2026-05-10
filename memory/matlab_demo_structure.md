# Memory: MATLAB Demo Structure

## Recommended directory layout

For each MATLAB concept demo, use:

- `demos/<topic>/scripts/` for runnable experiment scripts.
- `demos/<topic>/functions/` for reusable helper functions.
- `demos/<topic>/data/` for generated or source datasets.
- `demos/<topic>/figures/` for exported plots and result images.

## Naming and workflow

- Main entry script: `run_<topic>_demo.m`.
- Config script or struct: `config_<topic>.m`.
- Save outputs with timestamps for easy comparison.
- Keep deterministic seeds for reproducible experiments.
