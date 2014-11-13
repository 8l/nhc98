\documentstyle[11pt,a4,fpart,fpbib]{article}
\def\author{David Lester}
\def\fromemail{dlester@@cs.man.ac.uk}
\def\doctype{Benchmark-0002}
\def\title{Probabalistic Primality Testing}
% Filled in on creation of document: \author, \fromemail, \doctype and \title 

% RCS amended stuff
%$Log: Main.lhs,v $
%Revision 1.1  2004/08/05 11:13:39  malcolm
%Add a regression testsuite for the nhc98 compiler.  It isn't very good,
%but it is better than nothing.  I've been using it for about four years
%on nightly builds, so it's about time it entered the repository!  It
%includes a slightly altered version of the nofib suite.
%Instructions are in the README.
%
%Revision 1.2  1996/07/25 21:32:56  partain
%Bulk of final changes for 2.01
%
%Revision 1.1  1996/01/08 20:04:20  partain
%Initial revision
%
%Revision 1.2  92/06/30  15:56:32  dlester
%Added command intepreter.
%
%Revision 1.1  92/06/30  13:57:47  dlester
%Initial
%
%$Author: malcolm $
%$State: Exp $
%$Revision: 1.1 $
%$Date: 2004/08/05 11:13:39 $

% Constant stuff (at the moment).

\def\acknowledge{}	% delete this if you have no affiliation acks
\def\fromaddress{Functional Programming Group,\\Department of Computer Science,
Manchester University,\\Oxford Road,
Manchester M13 9PL, UK.}

\rcsheadings{}		% Prints RCS info at top of each page
			% ... delete if not wanted.
\begin{document}
\fptitle{}
\keywords{Primality, Probabalistic Algorithms}

\section{Command Interpreter}

> module Main where
> import IntLib
> import Random
> import Prime

Let's begin by giving Lester's line based command intepreter for
programs with @state@.

> main = getContents >>= \ cts -> sequence (map putStr (process (lines cts)))

The @process@ function takes a list of input lines and produces a list
of output lines.

> process :: [String] -> [String]
> process = doInput initState

To do this we consider each input line in turn in @doInput@; this
passes along the @state@.

> doInput :: State -> [String] -> [String]
> doInput state []     = []
> doInput state (l:ls) = doLine l (\state -> doInput state ls) state

The @doLine@ function processes an individual line.

> doLine :: String -> (State -> [String]) -> State -> [String]
> doLine cs cont rs
>  = if t then "Probably prime": rest else "Composite": rest
>    where n        = readInteger cs
>          (t, rs') = multiTest 100 rs n
>          rest     = cont rs'

And, for the particular problem we have in mind, we make the following
definitions.

> type State = [Int]
> initState  = randomInts 111 47

\input{Prime}
\input{Random}
\input{IntLib}
\end{document}
