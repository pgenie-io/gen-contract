# v5.0.0

## Breaking

- `Scalar`'s `Custom` alternative now carries a `CustomTypeRef` (`{ name, pgSchema, pgName, index }`) instead of a bare `Name`. `index` points into `Project.customTypes`, making custom-type references resolvable in Dhall — a generator can look up the referenced type's `CustomTypeDefinition` and authentic `pgSchema`/`pgName` directly, instead of only knowing its identifier (Dhall has no `Text` equality/inspection, so name-only references were previously opaque).
- New contract invariant: `Project.customTypes` must be topologically sorted — every index reachable from `customTypes[i]` is `< i`, ties broken alphabetically by `pgSchema` then `pgName`. This is not enforced by the type system; producers (the pgenie CLI) must uphold it, and consumers (generators) may rely on it for cheap left-fold transitive analysis instead of recursion.
- `Value`'s `arraySettings : Optional ArraySettings` wrapper is now inlined directly onto `Value`: `dimensionality : Natural` and `elementIsNullable : Bool` sit alongside `scalar`, with `dimensionality = 0` meaning a bare scalar (`elementIsNullable` is then meaningless). Removes the `ArraySettings` type and the `Optional`-unwrapping boilerplate every generator had to repeat.

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
