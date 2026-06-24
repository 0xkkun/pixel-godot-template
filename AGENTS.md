# Agent Guide

This repository is a Godot template. Keep reusable code, scenes, docs, and filenames neutral so downstream games can replace the sample content without inheriting a sample domain.

## Baseline

- Godot: `4.6.3.stable.official.7d41c59c4`
- Standard non-.NET editor/runtime
- Main scene: `res://scenes/lobby/lobby.tscn`
- Dev scene: `res://scenes/dev/main_dev.tscn`
- Quick gate: `bash scripts/verify_quick.sh`
- Full gate: `bash scripts/verify_full.sh`

## Workflow

1. Pick one GitHub issue and create a branch for that issue.
2. Keep the PR focused on one verifiable contract.
3. Prefer Godot MCP for editor/runtime checks when available.
4. Fall back to CLI checks when MCP is unavailable.
5. Run `bash scripts/verify_quick.sh` before opening or updating a PR.
6. Run `bash scripts/verify_full.sh` before merging broad changes.

## Godot MCP Checks

Use these when available:

- `get_godot_version`
- `run_project`
- `create_scene`
- `save_scene`
- `get_uid`

MCP success is not enough by itself. Always inspect the diff and run the verification scripts.

## Naming Rules

- Use neutral names such as `session_root`, `sample_actor`, `sample_interactable`, `InteractionSystem`, and `SessionSummaryUI`.
- Do not copy private project references, store identifiers, real service keys, or sample-specific vocabulary into reusable template files.
- Keep external SDK integrations disabled by default. Add adapter slots and examples instead of live integrations.

## Commit Hygiene

Do not commit:

- `.godot/`
- `build/`
- `exports/`
- `test-results/`
- local config files under `config/`
- service credentials or generated secrets

Commit asset-side Godot import metadata when real source assets are added.
