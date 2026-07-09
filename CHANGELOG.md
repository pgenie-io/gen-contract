# v4.0.1

## Patches

- Export `Report`, `File`, and `Output` at the top level of `src/package.dhall`,
  alongside `Project` and its constituent types. Previously these were
  private to the `module` constructor's `compile` return type and
  unavailable to contract consumers.

# v4.0.0

## Breaking

- Extracted this repository from `gen-sdk` as an independently versioned repo containing only the pGenie generator contract: the Dhall schema (`Project`, `module`).
- Removed the Haskell model projection (`PGenieGen.Model.Input`, `PGenieGen.Model.Output`) and the `model-test` suite. Both were absorbed into the [`pgenie`](https://github.com/nikita-volkov/pgenie) repo, which is now the only consumer of the Haskell model.
- Removed `docs/`; the generator architecture doc is now maintained in [`gen-sdk`](https://github.com/pgenie-io/gen-sdk).
- Renamed `dhall/` to `src/` and merged `Project.dhall` and `module.dhall` into a single `src/package.dhall`.
- Flattened the `src/package.dhall` exports: the model types (`Version`, `Name`, `Primitive`, `Scalar`, etc.) are now exported directly at the top level instead of nested under a `Project` field, alongside `module`.
