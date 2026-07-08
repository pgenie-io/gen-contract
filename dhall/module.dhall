-- Function for constructing standard pGenie generator modules.
-- Takes a contract version, a config type, and a compile function,
-- and returns a module with those components.
let Project = ./Project.dhall

let contractVersion = { major = 4, minor = 0 }

let Report = { path : List Text, message : Text }

let File = { path : Text, content : Text }

let Output =
      < Ok : { warnings : List Report, value : List File } | Err : Report >

in  \(Config : Type) ->
    \ ( compile
      : Optional Config -> Project.Project -> Output
      ) ->
      { contractVersion, Config, compile }
