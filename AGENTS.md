# AGENTS.md

This repository is the minimal pGenie generator contract repository.

## What this repo contains

- `src/package.dhall` is the entire generator contract in a single file: the
  canonical Dhall input model (`Project`) and the `module` constructor used by
  generator authors.

## Working rules

- Keep the contract self-contained in `src/package.dhall`; do not split it
  back into multiple files.
- The Haskell model projection of this contract
  (`PGenieGen.Model.Input` / `PGenieGen.Model.Output`) now lives in the
  [`pgenie`](https://github.com/pgenie-io/pgenie) repo. When changing the
  shape of `Project` here, update that projection and its compatibility test
  there too.
- Prefer Dhall formatting and validation for `src/package.dhall` changes.
- Never reference another `pgenie-io` repository via a local filesystem path. If this repo ever needs to depend on a sibling repo, use a pinned remote import (`https://raw.githubusercontent.com/pgenie-io/<repo>/<tag>/...` with a `sha256`), never a `../sibling-repo/...` path.

## Validation

- Use `dhall type --file "src/package.dhall"` for the repo's full build path (type-checks
  `src/package.dhall`).
