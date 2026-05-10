# Memory: MATLAB Demo Structure

## Recommended directory layout

For each MATLAB concept demo, use:

- `demo/<topic>/scripts/` for runnable experiment scripts.
- `demo/<topic>/functions/` for reusable helper functions.
- `demo/<topic>/data/` for generated or source datasets.
- `demo/<topic>/figures/` for exported plots and result images.

If one topic has multiple demo variants, use:

- `demo/<topic>/<variant>/scripts/`
- `demo/<topic>/<variant>/functions/`
- `demo/<topic>/<variant>/data/`
- `demo/<topic>/<variant>/figures/`

## Naming and workflow

- Main entry script: `run_<topic>_demo.m`.
- Config script or struct: `config_<topic>.m`.
- Save outputs with timestamps for easy comparison.
- Keep deterministic seeds for reproducible experiments.
