# Testing

The template uses Godot headless scenes plus small Python static checks.

## Commands

```sh
bash scripts/verify_quick.sh
bash scripts/verify_full.sh
```

Quick verification covers:

- environment and Godot version
- static project contract
- domain-neutral reusable surface
- import metadata hygiene
- secret hygiene
- headless editor load
- unit tests
- integration tests

Full verification adds:

- functional smoke
- runtime smoke for the main scene
- runtime smoke for the dev scene
- tooling regression checks

## Test Locations

- `tests/unit/`
- `tests/integration/`
- `tests/functional/`
- `tests/tooling/`
- `tests/support/test_runner.gd`

Every `test_*` method must execute at least one assertion.
