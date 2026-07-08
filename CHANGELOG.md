# Upcoming

## Breaking

- Extracted this repository from `gen-sdk` as an independently versioned repo containing only the pGenie generator contract: the Dhall schema (`Project`, `module`) and its Haskell model projection (`PGenieGen.Model.Input`, `PGenieGen.Model.Output`), plus the `model-test` suite that verifies the two stay synchronized.

## Fixes

- Rename `haskell/pgenie-gen.cabal` to `haskell/pgenie-gen-contract.cabal` to match the package's `name` field. The mismatch broke fetching this repo as a cabal git dependency.
