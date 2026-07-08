module PGenieGen.Prelude
  ( module Exports,
    Text,
    Natural,
    NonEmpty (..),
    Generic,
  )
where

import Data.List.NonEmpty (NonEmpty (..), nonEmpty)
import Data.Text (Text)
import GHC.Generics (Generic)
import Numeric.Natural (Natural)
import Prelude as Exports
