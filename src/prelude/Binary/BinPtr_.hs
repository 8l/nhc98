module NHC.Binary
  ( {-type-} BinPtr(..)
  , incBinPtr
  , unsafeShiftBinPtr
  , sizeofBinPtr
  , binPtr2Int
  , int2BinPtr
  ) where


----------------------------------------
newtype BinPtr = BP Int deriving (Eq,Ord,Show)

instance Enum BinPtr where
  fromEnum (BP i)  = i
  toEnum    i      = BP i
  enumFrom  (BP i) = map BP [i..]
  enumFromThen (BP i) (BP j) = map BP [i,j..]
----------------------------------------

unsafeShiftBinPtr :: Int -> BinPtr -> BinPtr
unsafeShiftBinPtr s (BP i) = BP (i+s)

sizeofBinPtr :: Int
sizeofBinPtr = 32

-- Increment a bin pointer by a bin pointer's width.
incBinPtr :: BinPtr -> BinPtr
incBinPtr = unsafeShiftBinPtr sizeofBinPtr

-- Allow the use of literal 0 to denote a valid BinPtr.
instance Num BinPtr where
  fromInteger n = BP (fromInteger n)

-- Not sure whether this is needed.
-- Re-introduced May 1998.
binPtr2Int :: BinPtr -> Int
binPtr2Int (BP n) = n

int2BinPtr :: Int -> BinPtr
int2BinPtr = BP

----------------------------------------