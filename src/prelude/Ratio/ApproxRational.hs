module Ratio where

import DRatio
import TRational
import Num_Ratio

-- approxRational, applied to two real fractional numbers x and epsilon,
-- returns the simplest rational number within epsilon of x.  A rational
-- number n%d in reduced form is said to be simpler than another n'%d' if
-- abs n <= abs n' && d <= d'.  Any real interval contains a unique
-- simplest rational; here, for simplicity, we assume a closed rational
-- interval.  If such an interval includes at least one whole number, then
-- the simplest rational is the absolutely least whole number.  Otherwise,
-- the bounds are of the form q%1 + r%d and q%1 + r'%d', where abs r < d
-- and abs r' < d', and the simplest rational is q%1 + the reciprocal of
-- the simplest rational between d'%r' and d%r.

approxRational          :: (RealFrac a) => a -> a -> Rational
approxRational x eps    =  simplest (x-eps) (x+eps)
        where simplest x y | y < x      =  simplest y x
                           | x == y     =  xr
                           | x > 0      =  simplest' n d n' d'
                           | y < 0      =  negate (simplest' (negate n') d' (negate n) d)
                           | True  =  0 :% 1
                                        where xr@(n :% d) = toRational x
					      (n' :% d')  = toRational y

              simplest' n d n' d'       -- assumes 0 < n%d < n'%d'
                        | r == 0     =  q :% 1
                        | q /= q'    =  (q+1) :% 1
                        | True  =  (q*n''+d'') :% n''
                                     where (q,r)   = quotRem n d
                                           (q',r') = quotRem n' d'
					   (n'' :% d'') = simplest' d' r' d r
