# AGENTS.md

This repository is the minimal pGenie generator contract repository.

## What this repo contains

- `dhall/` is the generator contract: the canonical Dhall input model and the
  `module` constructor used by generator authors.
- `haskell/` is the Haskell model projection of the same contract, used by the
  pGenie CLI app. It contains only the model types and the Dhall↔Haskell
  interop test.

## Working rules

- Treat `dhall/Project.dhall` and the Haskell model under
  `haskell/library/PGenieGen/Model*` as a synchronized pair.
- When changing the contract, update the compatibility tests in
  `haskell/model-test/Main.hs` so record fields and union alternatives stay
  aligned.
- Keep edits focused; do not touch generated build artifacts in `dist-newstyle/`
  unless the task explicitly requires regeneration.
- Prefer Dhall formatting and validation for `dhall/` changes.

## Validation

- Use `./build.bash` for the repo's full build path.
- The repository has a single Cabal test suite, `model-test`, for Dhall/Haskell
  model compatibility.
