module Time where

import qualified Ix

data Day = Sunday | Monday | Tuesday | Wednesday | Thursday
         | Friday | Saturday
         deriving (Eq, Ord, Enum, Bounded, Ix.Ix, Read, Show)
