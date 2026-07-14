-- | The pGenie generator contract: the codegen API model used as input to
-- generators, and the `module` constructor used to assemble a generator
-- module from a contract version, a config type, and a compile function.
let contractVersion =
    -- | The version of this schema.
    -- Generators can compare it against the version they were built for.
      { major = 5, minor = 0 }

let NonEmpty =
    -- | A hand-rolled non-empty list to avoid a dependency on Prelude just to get it.
      \(a : Type) -> { head : a, tail : List a }

let Version =
    -- | Semantic version of the target project (`Project.version`) - not
    -- this contract's own version (`contractVersion`).
      { major : Natural, minor : Natural, patch : Natural }

let Name =
    -- | An identifier pre-rendered in every casing convention a generator
    -- might need, so generators never have to reimplement case conversion.
      { inCamelCase : Text
      , inPascalCase : Text
      , inKebabCase : Text
      , inTrainCase : Text
      , inScreamingKebabCase : Text
      , inSnakeCase : Text
      , inCamelSnakeCase : Text
      , inScreamingSnakeCase : Text
      }

let Primitive =
    -- | PostgreSQL primitive type.
    --
    -- `Bit` - `bit` (OID 1560, array OID 1561).
    -- `Bool` - `bool` (OID 16, array OID 1000).
    -- `Box` - `box` (OID 603, array OID 1020).
    -- `Box2D` - `box2d` (PostGIS extension type).
    -- `Box3D` - `box3d` (PostGIS extension type).
    -- `Bpchar` - `bpchar` / `char(n)` (OID 1042, array OID 1014).
    -- `Bytea` - `bytea` (OID 17, array OID 1001).
    -- `Char` - internal single-byte `"char"` (OID 18, array OID 1002).
    -- `Cidr` - `cidr` (OID 650, array OID 651).
    -- `Circle` - `circle` (OID 718, array OID 719).
    -- `Citext` - `citext` (extension type).
    -- `Date` - `date` (OID 1082, array OID 1182).
    -- `Datemultirange` - `datemultirange` (OID 4535, array OID 6150).
    -- `Daterange` - `daterange` (OID 3912, array OID 3913).
    -- `Float4` - `float4` / `real` (OID 700, array OID 1021).
    -- `Float8` - `float8` / `double precision` (OID 701, array OID 1022).
    -- `Geography` - `geography` (PostGIS extension type).
    -- `Geometry` - `geometry` (PostGIS extension type).
    -- `Hstore` - `hstore` extension type (no fixed OID; requires the hstore extension).
    -- `Inet` - `inet` (OID 869, array OID 1041).
    -- `Int2` - `int2` / `smallint` (OID 21, array OID 1005).
    -- `Int4` - `int4` / `integer` (OID 23, array OID 1007).
    -- `Int4multirange` - `int4multirange` (OID 4451, array OID 6154).
    -- `Int4range` - `int4range` (OID 3904, array OID 3905).
    -- `Int8` - `int8` / `bigint` (OID 20, array OID 1016).
    -- `Int8multirange` - `int8multirange` (OID 4536, array OID 6157).
    -- `Int8range` - `int8range` (OID 3926, array OID 3927).
    -- `Interval` - `interval` (OID 1186, array OID 1187).
    -- `Json` - `json` (OID 114, array OID 199).
    -- `Jsonb` - `jsonb` (OID 3802, array OID 3807).
    -- `Line` - `line` (OID 628, array OID 629).
    -- `Lseg` - `lseg` (OID 601, array OID 1018).
    -- `Ltree` - `ltree` (extension type).
    -- `Macaddr` - `macaddr` (OID 829, array OID 1040).
    -- `Macaddr8` - `macaddr8` (OID 774, array OID 775).
    -- `Money` - `money` (OID 790, array OID 791).
    -- `Name` - `name` (OID 19, array OID 1003).
    -- `Numeric` - `numeric` (OID 1700, array OID 1231).
    -- `Nummultirange` - `nummultirange` (OID 4532, array OID 6151).
    -- `Numrange` - `numrange` (OID 3906, array OID 3907).
    -- `Oid` - `oid` (PostgreSQL object identifier type).
    -- `Path` - `path` (OID 602, array OID 1019).
    -- `PgLsn` - `pg_lsn` (OID 3220, array OID 3221).
    -- `PgSnapshot` - `pg_snapshot` (OID 5038, array OID 5039).
    -- `Point` - `point` (OID 600, array OID 1017).
    -- `Polygon` - `polygon` (OID 604, array OID 1027).
    -- `Text` - `text` (OID 25, array OID 1009).
    -- `Time` - `time` (OID 1083, array OID 1183).
    -- `Timestamp` - `timestamp` (OID 1114, array OID 1115).
    -- `Timestamptz` - `timestamptz` (OID 1184, array OID 1185).
    -- `Timetz` - `timetz` (OID 1266, array OID 1270).
    -- `Tsmultirange` - `tsmultirange` (OID 4533, array OID 6152).
    -- `Tsquery` - `tsquery` (OID 3615, array OID 3645).
    -- `Tsrange` - `tsrange` (OID 3908, array OID 3909).
    -- `Tstzmultirange` - `tstzmultirange` (OID 4534, array OID 6153).
    -- `Tstzrange` - `tstzrange` (OID 3910, array OID 3911).
    -- `Tsvector` - `tsvector` (OID 3614, array OID 3643).
    -- `Uuid` - `uuid` (OID 2950, array OID 2951).
    -- `Varbit` - `varbit` (OID 1562, array OID 1563).
    -- `Varchar` - `varchar` / `character varying` (OID 1043, array OID 1015).
    -- `Xml` - `xml` (OID 142, array OID 143).

      < Bit
      | Bool
      | Box
      | Box2D
      | Box3D
      | Bpchar
      | Bytea
      | Char
      | Cidr
      | Circle
      | Citext
      | Date
      | Datemultirange
      | Daterange
      | Float4
      | Float8
      | Geography
      | Geometry
      | Hstore
      | Inet
      | Int2
      | Int4
      | Int4multirange
      | Int4range
      | Int8
      | Int8multirange
      | Int8range
      | Interval
      | Json
      | Jsonb
      | Line
      | Lseg
      | Ltree
      | Macaddr
      | Macaddr8
      | Money
      | Name
      | Numeric
      | Nummultirange
      | Numrange
      | Oid
      | Path
      | PgLsn
      | PgSnapshot
      | Point
      | Polygon
      | Text
      | Time
      | Timestamp
      | Timestamptz
      | Timetz
      | Tsmultirange
      | Tsquery
      | Tsrange
      | Tstzmultirange
      | Tstzrange
      | Tsvector
      | Uuid
      | Varbit
      | Varchar
      | Xml
      >

let CustomTypeRef =
    -- | A resolvable reference to a custom type: its identifier plus its
    -- authentic Postgres identity (`pgSchema`, `pgName`) and its position
    -- in `Project.customTypes`.
      { name : Name
      , pgSchema : Text
      , pgName : Text
      , -- | An index into `Project.customTypes`. See that field's comment
        -- for the ordering invariant this index relies on.
        index : Natural
      }

let Scalar =
    -- | Either a primitive type or a custom type.
    --
    -- `Primitive` - a built-in PostgreSQL type.
    -- `Custom` - a project-defined type, referenced by `CustomTypeRef`.
      < Primitive : Primitive | Custom : CustomTypeRef >

let Value =
    -- | The type of a column or parameter: a scalar, optionally wrapped in
    -- `dimensionality` levels of array nesting (`1` for `T[]`, `2` for
    -- `T[][]`, etc.). `dimensionality = 0` means a bare scalar value, in
    -- which case `elementIsNullable` is meaningless and must be ignored.
      { dimensionality : Natural
      , -- | Whether individual array elements may be SQL NULL, independent
        -- of the containing value's own nullability (`Member.isNullable`).
        -- Meaningless when `dimensionality = 0`.
        elementIsNullable : Bool
      , scalar : Scalar
      }

let Member =
    -- | A single field of a composite type, or a query parameter/result
    -- column.
      { name : Name, pgName : Text, isNullable : Bool, value : Value }

let EnumVariant =
    -- | One value of a PostgreSQL enum type.
      { name : Name, pgName : Text }

let CustomTypeDefinition =
    -- | The definition of a custom type.
    --
    -- `Composite` - the fields of a `composite` type.
    -- `Enum` - the values of an `enum` type.
    -- `Domain` - the base value type of a `domain`.
      < Composite : List Member | Enum : List EnumVariant | Domain : Value >

let CustomType =
    -- | A project-defined custom type. `pgSchema` and `pgName` together
    -- form the key used to topologically sort `Project.customTypes`.
      { name : Name
      , pgSchema : Text
      , pgName : Text
      , definition : CustomTypeDefinition
      }

let ResultRowsCardinality =
    -- | How many rows a query's result may have.
    --
    -- `Optional` - at most one row (zero or one).
    -- `Single` - exactly one row, guaranteed by the query.
    -- `Multiple` - any number of rows, zero or more.
      < Optional | Single | Multiple >

let ResultRows =
    -- | The shape of a query's result when it does return rows: how many
    -- (`cardinality`) and their columns (at least one, by `NonEmpty`).
      { cardinality : ResultRowsCardinality, columns : NonEmpty Member }

let Result =
    -- | The classification of a query's result.
    --
    -- `Void` - the query returns nothing (e.g. DDL, `SET`).
    -- `RowsAffected` - the query returns only an affected-row count (e.g.
    -- `UPDATE`/`DELETE` without `RETURNING`).
    -- `Rows` - the query returns rows, described by `ResultRows`.
      < Void | RowsAffected | Rows : ResultRows >

let Var =
    -- | A reference to a query parameter at a specific position within a
    -- query's SQL text (see `QueryFragment`).
      { name : Name
      , -- | The parameter's raw name as written in the source SQL, before
        -- casing conversion.
        rawName : Text
      , -- | The parameter's 0-based position among the query's distinct
        -- parameters, assigned in first-occurrence order. Repeated
        -- references to the same named parameter share the same index.
        paramIndex : Natural
      }

let QueryFragment =
    -- | One fragment of a query's SQL text, split at parameter boundaries.
    --
    -- `Sql` - a literal slice of SQL text.
    -- `Var` - a parameter reference, interpolated by position when a
    -- generator reassembles the final query.
      < Sql : Text | Var : Var >

let QueryFragments =
    -- | A query's SQL text, split into `Sql`/`Var` fragments at parameter
    -- boundaries.
      List QueryFragment

let Query =
    -- | A single SQL query: its parsed fragments, parameters, and result
    -- shape.
      { name : Name
      , srcPath : Text
      , -- | Whether the query returns exactly the values it receives as
        -- parameters, unchanged. Used to test generators' round-trip type
        -- handling via gen-sdk's `Fixtures/Exhaustive.dhall`. Not a
        -- property ordinary production queries need to set meaningfully.
        identity : Bool
      , -- | Whether the query is safe to execute more than once with the
        -- same effect (e.g. no plain `INSERT` without conflict handling).
        -- Generators/clients may use this to decide retry safety.
        idempotent : Bool
      , params : List Member
      , result : Result
      , fragments : QueryFragments
      }

let Migration =
    -- | One SQL migration file. Migrations run in the order they appear
    -- in `Project.migrations`.
      { name : Text, sql : Text }

let Project =
    -- | The top-level input to a generator: everything describing one
    -- pGenie project.
      { space : Name
      , name : Name
      , version : Version
      , -- | Every custom type used by the project. Must be topologically
        -- sorted: every index reachable from `customTypes[i]` is `< i`,
        -- ties broken alphabetically by `pgSchema` then `pgName`. This is
        -- not enforced by the type system - producers (the pgenie CLI)
        -- must uphold it, and consumers (generators) may rely on it for
        -- cheap left-fold transitive analysis instead of recursion.
        customTypes : List CustomType
      , queries : List Query
      , migrations : List Migration
      }

let Report =
    -- | A diagnostic message reported by a generator (warning or fatal
    -- error), with a `path` breadcrumb locating where it applies.
      { path : List Text, message : Text }

let File =
    -- | One generated output file: its path and content.
      { path : Text, content : Text }

let Output =
    -- | The result of running a generator's `compile` function.
    --
    -- `Ok` - the generator succeeded, producing `value` (the generated
    -- files) and any non-fatal `warnings`.
    -- `Err` - the generator failed with a single fatal `Report`.
      < Ok : { warnings : List Report, value : List File } | Err : Report >

let module =
    -- | Assembles a generator module from a `Config` type and a `compile`
    -- function, tagging it with `contractVersion` so consumers can check
    -- compatibility.
      \(Config : Type) ->
      \(compile : Optional Config -> Project -> Output) ->
        { contractVersion, Config, compile }

in  { Project
    , Version
    , Name
    , Primitive
    , Scalar
    , Value
    , EnumVariant
    , CustomTypeDefinition
    , CustomType
    , CustomTypeRef
    , Member
    , ResultRowsCardinality
    , ResultRows
    , Result
    , Var
    , QueryFragment
    , QueryFragments
    , Query
    , Report
    , File
    , Output
    , module
    }
