# Repository Guide for People and Agents

This repository is a personal knowledge graph for study topics, implementation skills, demos, plans, and project notes. Keep changes organized by folder purpose so both humans and AI agents can quickly understand where new information belongs.

## Folder Structure

### `topics/`

Topic notes for concepts being studied.

Use this folder for:

- Concept summaries.
- Prerequisites and related topics.
- Learning status.
- Links to demos, workflow figures, or implementation notes.

Example: `topics/ransac.md`, `topics/l_bfgs.md`.

### `skills/`

Skill notes that describe implementation abilities or practical tasks built from topics.

Use this folder for:

- Implementation procedures.
- Inputs, outputs, validation criteria.
- Practical checklists for turning concepts into working code.

Example: `skills/implement_ransac_demo_matlab.md`.

### `demo/`

Runnable demonstration code.

Use this folder for:

- MATLAB/Python scripts.
- Reusable helper functions.
- Demo data and generated figures.

Expected layout:

```text
demo/<topic>/
  scripts/
  functions/
  data/
  figures/
```

For topics with multiple demo variants, nest the same structure one level deeper:

```text
demo/<topic>/<variant>/
  scripts/
  functions/
  data/
  figures/
```

Keep source code in `scripts/` and `functions/`. Use `.gitkeep` for empty `data/` or `figures/` folders. Avoid committing generated plots unless they are intentionally part of a result record.

### `algorithm_workflow/`

Standalone workflow diagrams and algorithm figures.

Use this folder for:

- SVG diagrams.
- Algorithm flowcharts.
- Visual references used by topic notes.

Topic markdown files should reference these assets instead of embedding large SVG blocks directly.

Example:

```md
![RANSAC algorithm workflow](../algorithm_workflow/ransac_workflow.svg)
```

### `plan/`

Permanent planning folder. Do not delete this folder.

Use this folder for:

- This-week plans.
- Short-term plans.
- Long-term plans.
- Implementation plans waiting for user-provided code.
- Archived or summarized plans.

Completed plan files can be archived, renamed, or summarized, but the `plan/` folder itself should remain in the repository.

Plans are grouped by year first. Short-term plans live under `plan/<year>/short_term/` and use year plus ISO week number, such as `plan/2026/short_term/2026-W19.md`. Long-term plans live under `plan/<year>/long_term/` and use year plus month, such as `plan/2026/long_term/2026-05.md`.

### `projects/`

Project-level notes that combine multiple skills and topics.

Use this folder for:

- Larger study or implementation projects.
- Project requirements.
- Links between skills, topics, and deliverables.

### `memory/`

Long-lived repository memory and conventions.

Use this folder for:

- Stable design decisions.
- Directory conventions.
- Reusable notes that should guide future edits.

Example: `memory/matlab_demo_structure.md`.

### `complement/`

Supplementary logs, observations, and maintenance notes.

Use this folder for:

- Weekly review notes.
- Lessons learned.
- Follow-up ideas.
- Small corrections that do not yet belong in a topic or skill file.

### `graph.yaml`

Main structured knowledge graph index.

Use this file to record:

- Global goals.
- Topics.
- Skills.
- Projects.
- Memory entries.
- Review metadata.

When adding a meaningful topic, skill, project, or memory file, update `graph.yaml` if it should become part of the graph.

### `.gitignore`

Repository ignore rules.

Currently ignores local editor configuration such as `.vscode/`.

### `.vscode/`

Local editor settings. This folder is ignored and should not be committed.

## Editing Guidelines

- Keep topic notes concise and link to demos or diagrams instead of duplicating large assets inline.
- Put runnable code under `demo/`, not under `topics/`.
- Put workflow figures under `algorithm_workflow/`.
- Put future work and weekly tasks under `plan/`.
- Keep `plan/` permanently available.
- Update `graph.yaml` when repository structure or graph-level metadata changes.
- Do not delete folders that define repository structure just because their old contents are complete.
