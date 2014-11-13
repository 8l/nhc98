From: Koen Claessen [mailto:koen@cs.chalmers.se] 
Sent: Wednesday, January 27, 1999 3:05 PM
To: glasgow-haskell-bugs-outgoing@dcs.gla.ac.uk
Subject: Possible bug


Hi,

I have been doing probability theory tests. One of them involved the so
called "secretary problem". Here is my code:

\begin{code}
module Main where

import Random
import List
import IO
import Monad
#ifdef __NHC__
import IOExtras
fromInt = fromInteger . toInteger
#else
import IOExts
#endif

type Process = [Integer] -> Bool

-- added by SimonM
randomRIOs :: Random a => (a,a) -> IO [a]
randomRIOs rng 
  = do rs <- unsafeInterleaveIO (randomRIOs rng)
       r  <- randomRIO rng
       return (r:rs)

-- modified for Haskell 98 by SimonM
simulate :: Int -> Integer -> Process -> IO Double
simulate n m proc =
  do tries <- sequence [ fmap proc (randomRIOs (1,m)) | _ <- [1..n] ]
     return (length (filter id tries) // n)
 where
  n // m = fromInt n / fromInt m

sim :: Int -> IO Double
sim k = simulate 1000 100 proc
 where
  proc rs = [best] == take 1 afterk
   where
    xs     = take 100 (nub rs)
    best   = 100
    bestk  = maximum (take k xs)
    afterk = dropWhile (< bestk) (drop k xs)

main :: IO ()
main =
  do ps <- sequence [ sim k | k <- [35..39] ]
     print ps
\end{code}

When I run this module with ghc-4.01, I get _wrong_ results, and a bus
error:

	[koen] -: ghc-4.01 -O secretary.hs -o secretary
	ghc-4.01: module version changed to 2; reason: usages changed
	[koen] -: secretary
	[3.3e-2,0.0,0.0,0.354,0.174]
	Bus error

The right behavior should be like:

	[koen] -: hbc secretary.hs -o secretary
	[koen] -: secretary
	[0.398, 0.386, 0.376, 0.353, 0.363]

Or even:

	Hugs> main
	[0.366, 0.369, 0.383, 0.383, 0.379]

I am trying to find out if it is because of the random numbers, or because
of the use of -O. But these programs take ages to run...

Regards,
Koen.

--
Koen Claessen,
koen@cs.chalmers.se,
http://www.cs.chalmers.se/~koen,
Chalmers University of Technology.

