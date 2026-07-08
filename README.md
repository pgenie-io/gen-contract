# gen-contract

[![Continuous Docs for Dhall](https://img.shields.io/badge/dhall_docs-master-blue)](https://pgenie-io.github.io/gen-contract/dhall/)
[![Continuous Docs for Haskell](https://img.shields.io/badge/haskell_docs-master-blue)](https://pgenie-io.github.io/gen-contract/haskell/)

Minimal contract repository for [pGenie](https://pgenie.io) code generators.

This repository versions the *implicit concept* of the pGenie generator contract.
Both the Dhall schema and the Haskell model projection are kept here, together
with a small integration test that verifies the two stay synchronized.

> [!IMPORTANT]
> This library relies on a fork of Dhall that provides primitives for `Natural/equal` and `Natural/lessThan`. These have been [PRd](https://github.com/dhall-lang/dhall-haskell/pull/2739) into the main repo. Until they get merged you will need to use the custom Dhall binary provided in https://github.com/nikita-volkov/dhall-haskell.

## Structure

### `dhall/`

The Dhall side is the contract for generator authors. It is the source of truth
for the codegen model. See the [Dhall docs](https://pgenie-io.github.io/gen-contract/dhall/)
for the full reference.

The entry point is `package.dhall`, which exposes:

- **`Project`** — the input model describing a PostgreSQL project: queries, custom types, primitive types, migrations, and related metadata
- **`module`** — the constructor used to assemble a generator module from a contract version, a config type, and a compile function

A minimal generator looks like this:

```dhall
let Contract = https://raw.githubusercontent.com/pgenie-io/gen-contract/<tag>/dhall/package.dhall

in  Contract.module
      ./Config.dhall
      ./compile.dhall
```

For a real-world example see [haskell-hasql.gen](https://github.com/pgenie-io/haskell-hasql.gen).

### `haskell/`

The Haskell side is the model projection used by the pGenie CLI app and by
Dhall/Haskell interop tests. It exposes the same generator input and output
model as the Dhall schema. See the [Haskell docs](https://pgenie-io.github.io/gen-contract/haskell/)
for details.

## Why they live together

The Dhall contract and the Haskell model need to agree on the same types.
Keeping them in one repository makes it easier to keep the schema and the
compatibility test in sync so changes to the contract are validated before
release.
