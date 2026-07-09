# gen-contract

[![Continuous Docs for Dhall](https://img.shields.io/badge/dhall_docs-master-blue)](https://pgenie-io.github.io/gen-contract/)

Contract repository for [pGenie](https://pgenie.io) code generators.

## Structure

### `src/`

The entry point and only file is `package.dhall`, which exposes:

- **`Project`** — the input model describing a PostgreSQL project: queries, custom types, primitive types, migrations, and related metadata
- **`module`** — the constructor used to assemble a generator module from a contract version, a config type, and a compile function

A minimal generator looks like this:

```dhall
let Contract = https://raw.githubusercontent.com/pgenie-io/gen-contract/<tag>/src/package.dhall

in  Contract.module
      ./Config.dhall
      ./compile.dhall
```

For a real-world example see [haskell-hasql.gen](https://github.com/pgenie-io/haskell-hasql.gen).

## The Haskell model projection

The Haskell projection of this contract (`PGenieGen.Model.Input` /
`PGenieGen.Model.Output`) used to live in this repository under `haskell/`. It
has been absorbed into the [`pgenie`](https://github.com/nikita-volkov/pgenie)
CLI app, which is now its only consumer.
