\chapter{Transcendental Functions}

\begin{verbatim}
$Log: Transcendentals.lhs,v $
Revision 1.1  2004/08/05 11:12:53  malcolm
Add a regression testsuite for the nhc98 compiler.  It isn't very good,
but it is better than nothing.  I've been using it for about four years
on nightly builds, so it's about time it entered the repository!  It
includes a slightly altered version of the nofib suite.
Instructions are in the README.

Revision 1.2  1999/11/02 16:10:42  simonpj
Haskell 98 changes

Revision 1.1  1996/01/08 20:05:19  partain
Initial revision

\end{verbatim}

> module Transcendentals
>  (module ContinuedFractions, 
>   exp1, expQ, expR, log10, logQ, logR, tanQ, tanR, cotR, atan1, atanQ, atanR)
> where
> import ContinuedFractions

\section{Basic Transcendental Functions}

In this section we show how to use Gauss' continued fraction
representation of $F(\alpha , 1, \gamma ; x)$ to implement the basic
transcendental functions: $\exp$, $\log$, $\tan$, and $\arctan$.

As a reminder, $F(\alpha , \beta , \gamma ; x)$ is the following series:
\[1 + \frac{\alpha \beta}{1! \gamma}x +
\frac{\alpha(\alpha +1) \beta (\beta +1)}{2! \gamma(\gamma +1)}x^2 +
\frac{\alpha(\alpha +1)(\alpha +2) \beta (\beta +1)(\beta +2)}%
{3! \gamma(\gamma +1)(\gamma +2)}x^3 +
\ldots \]

Modifying Gauss' formulation of the continued fraction we get that
$F(\alpha , 1, \gamma ; x)$ is:

\[ [0,~1,~\frac{1}{\alpha}(\frac{\gamma}{-x}),
~\frac{\alpha}{\gamma-\alpha}(\gamma+1),~
p_0(\frac{\gamma +2}{-x}),~p'_0(\gamma +3)~\ldots~
p_{n}(\frac{\gamma +2n+2}{-x}),~ p'_{n}(\gamma +2n+3),~ \ldots ] \]
where
\[p_n = \frac{1}{\alpha}\prod_{i=0}^n \frac{(\gamma - \alpha +i)(i+1)}%
{(\alpha +i+1)(\gamma +i)}\]
and
\[p'_n = \frac{\alpha}{\gamma-\alpha}
\prod_{i=0}^n \frac{(\alpha +i+1)(\gamma +i)}%
{(\gamma - \alpha +i+1)(i+2)}\]

This often simplifies.

\subsection{Exponential}

Gauss gives the following representation of $\exp(x)$:
$\lim_{k\to\infty}F(k,1,1;\frac{x}{k})$. If we expand this we have
the following continued fraction:

\[ [0,~1,~1.(\frac{-1}{x}),-2,~3.(\frac{1}{x}),~\frac{4}{2},~
5.(\frac{-1}{x}),~\frac{-6}{3},~\ldots~]\]
We then observe that $\exp(x) = \frac{1}{\exp(-x)}$ getting:
\[ [1,~\frac{1}{x},~-2,~\frac{-3}{x},~2,~\frac{5}{x},~-2,~\ldots ] \]

Setting $x$ to $1$ we have the following continued fraction for $e$:

> exp1CF :: [QRational]
> exp1CF = 1: f 0 where f n = (4*n+1): (-2): (-(4*n+3)): 2: f (n+1)

To use this continued fraction to generate the continued fraction for
$\exp(x)$, where $x\in {\cal Q}$, we simply multiply the even terms of
the continued fraction for $e$ by $\frac{1}{x}$ (treating the first
term as an even one). The starting homography for the modified
Algebraic Algorithm is generated by absorbing the first six terms of
the continued fraction. We then multiply the resultant continued
fraction by $x$. This is marginally more stable than Vuillemin's
formulation.

> expQ  :: QRational -> ContinuedFraction
> expQ  x = aaQ hom ts2
>           where (ts1,ts2)   = splitAt 2 cf
>                 hom         = absorbQ startH ts1
>                 (startH,cf) = if abs x < 1 then
>                               (([1,0],[0,1]), oddQ x exp1CF) else
>                               (([qDenominator x,0],[0,qNumerator x]),
>                                 evenQ (1/x) exp1CF) 

> exp1 :: ContinuedFraction
> exp1 = expQ (1%%1)

We use an exactly similar process for the case of continued fraction
arguments.

> expR  :: ContinuedFraction -> ContinuedFraction
> expR  x = if mightBeZero x
>           then processQS x (splitAt 6 (oddR exp1CF))
>           else quadraticAlgorithm ([0,1,1,0],[0,1,0,0]) x cf2
>           where cf2 = processQS x (splitAt 6 (oddR (tail exp1CF)))

\subsection{Logarithm}

Vuillemin's continued fraction is too unstable for values of $x-1$
which aren't near $0$. So instead we use Gauss' formula:
\[\log(\frac{1+x}{1-x}) = 2xF(\frac{1}{2},1,\frac{3}{2}; x^2)\]
It works because the transformation eliminates those values of $x$
in the above expansion that would cause problems, {\it e.g.} $|x|
\geq 0$.

The continued fraction for $F(\frac{1}{2},1,\frac{3}{2}; x^2)$ is
closely related to that for $\arctan(x)$, because:
\[\tanh^{-1}(x) = \frac{1}{2} \log(\frac{1+x}{1-x})\]
and
\[\imath \tanh(x) = \tan(\imath x).\]

> logQ  :: QRational -> ContinuedFraction
> logQ  x = aaQ startH ts2
>           where (ts1,ts2) = splitAt 2 (oddQ (-t*t) atan1CF)
>                 t         = (x-1)/(x+1)
>                 tn        = qNumerator t
>                 td        = qDenominator t
>                 startH    = absorbQ ([-2*td,0],[0,tn]) ts1

> log10 :: ContinuedFraction
> log10 = logQ (10%%1)

The nice part is that by requiring the multiplier @-t*t@ to be
less than @1@, we place no constraints on @x@ provided that it is
already in the range $(0,\infty )$.

> logR  :: ContinuedFraction -> ContinuedFraction
> logR  x = quadraticAlgorithm ([2,0,0,0],[0,0,0,1]) t cf1
>           where t   = algebraicAlgorithm ([1,(-1)],[1,1]) x
>                 t2  = quadraticAlgorithm ([-1,0,0,0],[0,0,0,1]) t t
>                 cf  = qsSetupAlt (drop 1 (oddR atan1CF)) t2
>                 cf1 = quadraticAlgorithm ([0,1,0,0],[0,1,1,0]) t2 cf

\subsection{Tangent}

For this function we use Lambert's Continued Fraction
\[\tan(x) = [0,~\frac{1}{x},~\frac{-3}{x},~\frac{5}{x},~\frac{-7}{x},~\ldots]\]

It is much more convenient if we can obtain a fraction with some
constant terms in it so we observe the following transformation is
possible:
\[\tan(x) = \frac{1}{x}[0,~\frac{1}{x^2},~-3,~\frac{5}{x^2},~-7,~\ldots]\]
provided that $x$ is non-zero.

> tan1CF :: [QRational]
> tan1CF = 0: f 0 where f n = (4*n+1) : (-(4*n+3)) : f (n+1)

> tanQ  :: QRational -> ContinuedFraction
> tanQ  x = if x /= 0 then aaQ startH ts2 else error "tanQ: 0 argument"
>           where n         = qRound (abs (x/2)) + 1
>                 (ts1,ts2) = splitAt (fromIntegral n) (bothQ x tan1CF)
>                 startH    = absorbQ ([1,0],[0,1]) ts1

> tanR  :: ContinuedFraction -> ContinuedFraction
> tanR  x = quadraticAlgorithm ([0,1,0,0],[0,0,1,0]) cfd cfn
>           where cf  = qsSetupAlt (drop 1 (oddR tan1CF)) x2
>                 x2  = quadraticAlgorithm ([1,0,0,0],[0,0,0,1]) x  x
>                 cfn = quadraticAlgorithm ([1,0,0,0],[0,0,0,1]) x  cf
>                 cfd = quadraticAlgorithm ([0,1,1,0],[0,0,0,1]) x2 cf

> cotR  :: ContinuedFraction -> ContinuedFraction
> cotR  x = quadraticAlgorithm ([0,1,0,0],[0,0,1,0]) cfn cfd
>           where cf  = qsSetupAlt (drop 1 (oddR tan1CF)) x2
>                 x2  = quadraticAlgorithm ([1,0,0,0],[0,0,0,1]) x  x
>                 cfn = quadraticAlgorithm ([1,0,0,0],[0,0,0,1]) x  cf
>                 cfd = quadraticAlgorithm ([0,1,1,0],[0,0,0,1]) x2 cf

\subsection{Arctangent}

Recall, from the discussion of the continued fraction for $\log$, that
the $\arctan(x)$ is $xF(\frac{1}{2},1,\frac{3}{2};-x^2)$ 
The terms in this continued fraction are tending towards $\pi$ and $1$.

> atan1CF :: [QRational]
> atan1CF = 0: 1: 3: 5/4: f (8/9) 0
>           where f :: QRational -> QRational -> [QRational]
>                 f p n = (7/2 + 2*n)*p: (9/2 + 2*n)*p': f p'' (n+1)
>                         where p'  = 1/(p*(n+2)*(n+2))
>                               p'' = 1/(p'*(n+5/2)*(n+5/2))

The @atanQ@ function is valid for $x \in (-\infty,\,\infty)$.

We note the following identities:
\[\mbox{for $x>0$ } \arctan(x) = \frac{\pi}{2} -\arctan(\frac{1}{x})\]
and
\[\mbox{for $x<0$ } \arctan(x) = -\frac{\pi}{2} -\arctan(\frac{1}{x})\]


> atanQ :: QRational -> ContinuedFraction
> atanQ x
>  = if x > 1  then
>       quadraticAlgorithm ([0,-1,2,0] ,[0,0,0,1]) atan1 (cf (1/x)) else
>    if x < -1 then
>       quadraticAlgorithm ([0,-1,-2,0],[0,0,0,1]) atan1 (cf (1/x)) else
>       cf x
>    where
>    cf x = aaQ startH ts2
>           where
>           (ts1,ts2) = splitAt 4 (oddQ (x*x) atan1CF)
>           startH    = absorbQ ([qDenominator x,0],[0,qNumerator x]) ts1

Because we will be using it to help improve the stability of the
$arctan$ function, we pre-define the constant continued fraction
$\pi/4$.

> atan1 :: ContinuedFraction
> atan1 = atanQ (1%%1)

> atanR :: ContinuedFraction -> ContinuedFraction
> atanR []         = algebraicAlgorithm ([2,0],[0,1]) atan1
> atanR xs@(x:xs')
>  = if x > 1 then
>       quadraticAlgorithm ([0,-1,2,0] ,[0,0,0,1]) atan1 ys else
>    if x < -1 then
>       quadraticAlgorithm ([0,-1,-2,0],[0,0,0,1]) atan1 ys else
>       atanRdirect xs
>    where ys = atanRdirect (algebraicAlgorithm ([0,1],[1,0]) xs)

> atanRdirect :: ContinuedFraction -> ContinuedFraction
> atanRdirect x
>  = quadraticAlgorithm ([0,0,1,0],[0,1,0,0]) cfn cfd
>    where x2  = quadraticAlgorithm ([1,0,0,0],[0,0,0,1]) x x
>          cf  = qsSetupAlt (drop 1 (oddR atan1CF)) x2
>          cfn = quadraticAlgorithm ([1,0,0,0],[0,0,0,1]) x  cf
>          cfd = quadraticAlgorithm ([0,1,1,0],[0,0,0,1]) x2 cf

\subsection{Tests on CFs}

We use @mightBeZero@ to test whether a continued fraction can be zero.

> mightBeZero :: ContinuedFraction -> Bool
> mightBeZero []     = False
> mightBeZero (x:xs) = x == 0

\section{Processing Rational Transcendentals}

In this section we deal with the case of transcendental functions of
rational arguments. We first define a variant of Gosper's Algenraic
Algorithm that takes a homography and a continued fraction with
rational terms, and returns an equivalent continued fraction with
integer terms.

> aaQ :: Homography -> [QRational] -> ContinuedFraction
> aaQ homography@([n0,n1],[d0,d1]) xs
>  = if n0*d1 /= n1*d0 then aaQNoCheck homography xs
>    else if d1 /= 0   then rat2cf (n1%%d1)
>    else if d0 /= 0   then rat2cf (n0%%d0) 
>    else                   error "aaQ: undefined homography"

As we did with the original formulation, we check the determinant of
the homography only once.

> aaQNoCheck homography@([n0,n1],[d0,d1]) []
>  = rat2cf (n0%%d0)
> aaQNoCheck homography@([n0,n1],[d0,d1]) xs'@(x:xs)
>  = case algebraicOutput homography x of
>      Just o  -> o : aaQNoCheck ([d0,d1],          [n0-d0*o,n1-d1*o]) xs'
>      Nothing ->     aaQNoCheck ([n0*n+n1*d,n0*d], [d0*n+d1*d,d0*d])  xs
>    where (n,d) = (qNumerator x, qDenominator x)

To absorb a finite sequence of terms from a rational continued fraction
we use @absorbQ@.

> absorbQ :: Homography -> [QRational] -> Homography
> absorbQ homography        []     = homography
> absorbQ ([n0,n1],[d0,d1]) (q:qs) = absorbQ ([n0*n+n1*d,n0*d],
>                                             [d0*n+d1*d,d0*d]) qs
>                                    where n = qNumerator   q
>                                          d = qDenominator q

To set up the continued fraction with the argument we use @bothQ@,
@oddQ@ and @evenQ@.

> bothQ :: QRational -> [QRational] -> [QRational]
> bothQ x (x1:xs) = x1/x:   bothQ x xs

> evenQ :: QRational -> [QRational] -> [QRational]
> evenQ x (x1:x2:xs) = x1/x: x2:   evenQ x xs

> oddQ :: QRational  -> [QRational] -> [QRational]
> oddQ  x (x1:x2:xs) = x1:   x2/x: oddQ  x xs

\section{Processing Irrational Transcendentals}

To produce continued fractions for the transcendental functions with
continued fraction arguments we use an ``infinite state machine''.
This infinite state is an infinite list of sub-states, each consisting
of a rational, and a homography for the Quadratic Algorithm.

> type State = (QRational, Homography)

To set up the initial continued fraction for the ``infinite state
machine'' from the initial continued fraction we use @oddR@.
If the initial continued fraction is
\[[\frac{a_0}{b_0},~\frac{a_1}{b_1},~\frac{a_2}{b_2},~\frac{a_3}{b_3},~\ldots]\]
then the ``infinite state'' will be:
\[[\left(\frac{a_0}{b_0},
   \left(\begin{array}[c]{cccc}0&a_1&b_1&0\\b_1&0&0&0\end{array}\right),~
\right)
\left(\frac{a_2}{b_2},
   \left(\begin{array}[c]{cccc}0&a_3&b_3&0\\b_3&0&0&0\end{array}\right)
\right),~
\ldots]\]

> oddR :: [QRational] -> [State]
> oddR (x1:x2:xs) = (x1,([0,xn,xd,0],[xd,0,0,0])): oddR xs
>                   where (xn,xd) = (qNumerator x2, qDenominator x2)

The processing of the infinite state and the continued fraction is
initiated by @processQS@.

> processQS :: ContinuedFraction -> ([State],[State]) -> ContinuedFraction
> processQS x (hs1,hs2) = preProcess x hs1 (qsSetupAlt hs2 x)

This in turn makes use of @preProcess@ which is used to absorb some of
the leading terms (@hs1@) and @qsSetupAlt@ which is used to process
the remainder (@hs2@).

> preProcess :: ContinuedFraction -> -- the argument CF
>               [State]           -> -- leading parts of infinite state
>               ContinuedFraction -> -- accumulating CF
>               ContinuedFraction    -- the resulting CF
> preProcess _ []         c = c
> preProcess x ((i,h):hs) c = algebraicAlgorithm ([ni,nd],[nd,0]) 
>                             (quadraticAlgorithm h x (preProcess x hs c))
>                             where ni = qNumerator i
>                                   nd = qDenominator i

To process the remainder of the infinite state, we use @qsSetupAlt@.

> qsSetupAlt :: [State] -> ContinuedFraction -> ContinuedFraction
> qsSetupAlt hs x = aaQ ([1,0],[0,1]) (qsProcess (hs, x))

\subsection{Quadratic Process}

In essence the state for the algorithm holds:
\begin{enumerate}
\item the infinite list of @Rational@/@Homography@ pairs; and
\item the infinite continued fraction of the argument.
\end{enumerate}

We advance by absorbing one term from the continued fraction or by
considering one more term of the infinite state.

> qsProcess :: ([State], ContinuedFraction) -> [QRational]
> qsProcess    (ihs, [])    = asProcess ihs
> qsProcess st@(ihs, (_:_)) = qsNext 1 st

The decision about whether sufficient accuracy has been achieved is
decided by @qsNext@. To do this a call to @qsTerm@ is made. This
returns a list of output values and a modified state (@ihs'@).  If the
output list is sufficiently long we can output them as part of the
resulting continued fraction. Alternatively we can absorb another term
of the argument continued fraction. In either case we consider one
more term of the infinite state.

> qsNext :: Int -> ([State], ContinuedFraction) -> [QRational]
> qsNext n (ihs, []) = asProcess (qsEnd ihs)
> qsNext n st@(((i,h):ihs), xs'@(x:xs))
>  = if length outs > 1
>       then init outs ++ qsNext (n+1) (ihs',xs')
>       else qsNext (n+1) (qsIn x ((i,h): ihs), xs)
>    where (outs, (ihs',_)) = qsTerm n st

The @qsTerm@ function considers the initial @n@ terms of the infinite
state, and the first term of the continued fraction for the argument.
From this it calculates a modified infinite state, in which, what is
effectively carry propogation has occurred.

> qsTerm :: Int -> ([State], ContinuedFraction)
>          -> ([QRational],([State], ContinuedFraction))
> qsTerm n (ihs,xs)
>  = (outs, (ihs',xs))
>    where (front,back@((i,_):_)) = splitAt n ihs
>          (outs,ihs') = foldr (qsTerm' (head xs)) ([i],back) front

To deal with each individual term of the infinite state we use @qsTerm'@.

> qsTerm' :: Integer -> State -> ([QRational], [State]) -> 
>                                ([QRational], [State])
> qsTerm' x ih@(i,h) (is,ihs)
>  = (is',((last is',h''):ihs))
>    where h' = qsAbsorb (init is) h
>          i' = last is
>          (is',h'') = qsEmit x i' ([i],h')

This in turn uses @qsAbsorb@ and @qsEmit@ to propogate the carry and
emit output terms, respectively.

> qsAbsorb :: [QRational] -> Homography -> Homography
> qsAbsorb [] h = h
> qsAbsorb (i:is) h@([n0,n1,n2,n3],[d0,d1,d2,d3])
>  = qsAbsorb is ([n0*n+n2*d, n1*n+n3*d, n0*d, n1*d],
>                 [d0*n+d2*d, d1*n+d3*d, d0*d, d1*d])
>    where n = qNumerator i
>          d = qDenominator i

@qsEmit@ is essentially a variant of the Quadratic Algorithm, capable
of dealing with the output of more than $1$ term at once.

> qsEmit :: Integer -> QRational -> ([QRational], Homography) ->
>                                 ([QRational], Homography)
> qsEmit x i ish@(is,h@([n0,n1,n2,n3],[d0,d1,d2,d3]))
>  = case quadraticOutput h [x%%1,i] of
>      Just o  -> qsEmit x i (is++[o%%1],
>                             ([d0,d1,d2,d3],
>                              [n0-d0*o, n1-d1*o, n2-d2*o, n3-d3*o]))
>      Nothing -> ish

To absorb the leading term of the argument continued fraction into
each Quadratic Homography we use @qsIn@.

> qsIn :: Integer -> [State] -> [State]
> qsIn = map . input
>        where input x (i,([n0,n1,n2,n3],[d0,d1,d2,d3]))
>                = (i, ([n0*x+n1, n0, n2*x+n3, n2],
>                       [d0*x+d1, d0, d2*x+d3, d2]))

\subsection{Finite Continued Fractions}

It is possible to generate finite continued fractions, so we need a
way to deal with @[]@ in the @qsProcess@. This results in a
degeneration to the algebraic process.

@qsEnd@ turns each Quadratic Homography into the equivalent Algebraic
Homography.

> qsEnd :: [State] -> [State]
> qsEnd = map input
>         where input (i,([n0,_,n2,_],[d0,_,d2,_]))
>                 = (i,([n0,n2],[d0,d2]))

The function @asProcess@ munges these homographies to produce an answer.

> asProcess :: [State] -> [QRational]
> asProcess ihs = fst (head ihs) : asProcess (asNext ihs)

> asNext :: [State] -> [State]
> asNext ((i,h@([n0,n1],[d0,d1])):ihs'@((i',_):ihs))
>  = case algebraicOutput h i' of
>      Just o  -> (o%%1, ([d0,d1], [n0-d0*o,n1-d1*o])): ihs'
>      Nothing -> asNext ((i,hIn i' h): asNext ihs')
>    where hIn x ([n0,n1],[d0,d1]) = ([n0*xn+n1*xd,n0*xd],[d0*xn+d1*xd,d0*xd])
>                                    where xn = qNumerator x
>                                          xd = qDenominator x

And that completes the implementation of the specified subset of
transcendental functions.


