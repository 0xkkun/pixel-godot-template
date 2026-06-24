# Customizing The Template

Use this guide for the first 30 minutes after creating a project from the template.

## 1. Rename

Update:

- `config/name` in `project.godot`
- `config/version` in `project.godot`
- local copy of `config/app.cfg.example`
- README title and repository links
- export paths in `export_presets.cfg`

Run `bash scripts/verify_quick.sh` after renaming project settings.

## 2. Replace

Replace the sample content once your first real vertical slice exists:

- `scenes/actors/sample_actor.tscn`
- `scripts/actors/sample_actor.gd`
- `scenes/interactables/sample_interactable.tscn`
- `scripts/interactables/sample_interactable.gd`
- `scenes/interactables/sample_pooled_marker.tscn`
- `scripts/interactables/sample_pooled_marker.gd`
- placeholder UI copy in `scenes/ui/session_ui_root.tscn`

Keep the public contract stable while replacing content:

- movement or input path
- interaction interface
- pooled lifecycle
- session summary signal path
- headless smoke coverage

## 3. Delete

Delete sample files only after replacement tests pass. Do not remove the harness entrypoints:

- `scripts/verify_quick.sh`
- `scripts/verify_full.sh`
- `scripts/godot_headless.sh`
- `tests/support/test_runner.gd`
- `.github/pull_request_template.md`
- `.github/workflows/verify.yml`
- `AGENTS.md`

## 4. Keep

Keep these contracts unless you intentionally redesign the template:

- Godot version is `4.6.3.stable.official.7d41c59c4`.
- `project.godot` autoload inventory matches `scripts/verify_project_contract.py`.
- Reusable names stay domain-neutral.
- Local config and credentials stay untracked.
- Every shared runtime change has a verification path.

## 5. Common Changes

Orientation:

- Change `window/handheld/orientation` in `project.godot`.
- Update docs if the template is no longer portrait-first.
- Run `bash scripts/verify_quick.sh`.

Input:

- Add input actions in Godot's Input Map.
- Update the sample actor or its replacement.
- Extend the smoke test to cover the new path.

Persistence:

- Extend `scripts/autoload/save_manager.gd`.
- Keep local-only config outside git.
- Add a unit or integration test for the new stored value.

Platform services:

- Add an adapter behind a neutral interface.
- Keep live service keys out of the repository.
- Document setup in `config/README.md` or a dedicated doc.

## 6. Agent Workflow

Give coding agents one issue at a time. A useful request looks like:

```text
Implement issue #4. Keep reusable names domain-neutral. Run bash scripts/verify_quick.sh and paste the output in the PR.
```

When a check fails, send the failing command and the relevant log from `test-results/`.
