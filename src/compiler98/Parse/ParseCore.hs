module Parse.ParseCore(
               Pos,ParseError,ParseResult,ParseBad,ParseGood,Parser
               ,initError,initBad,initGood      -- Start values for parseError,parseBad, parseGood
               ,parseit                         -- entry for parsing
               ,parse,ap,chk,orelse,into        -- The core
               ,token                           -- parse terminal
               ,parseFail                       -- Failing parser
               ,maxError                        -- Keep "best" error message
               ) where

import Util.Extra(noPos,Pos)

infixl 5 `ap`
infixl 5 `chk`
infixr 4 `orelse`


--- Define types
-- parameters:
-- i = input to be parsed
-- a = resulting syntax tree
-- c = other return value
type ParseError = (Pos,String,[String])
type ParseResult a i   = Either ParseError (a,i,ParseError) 
type ParseBad    a i   =           ParseError -> ParseResult a i 
type ParseGood   a i c = a -> i -> ParseError -> ParseResult c i
type Parser      a i c = ParseGood a i c -> ParseBad c i -> i -> ParseError ->  ParseResult c i 

--- start values
initError :: ParseError
initError = (noPos,"Hu?",["No error"])

initBad :: ParseBad a i
initBad = \err -> Left err

initGood :: ParseGood a i a
initGood = \res input err -> Right (res,input,err)

parseit :: Parser a i a -> i -> Either ParseError a

parseit p input = parseit' (p initGood initBad input initError)

parseit' :: Either err (a, b, c) -> Either err a
parseit' (Left err) = Left err
parseit' (Right (a,_,_)) = Right a

--- The core
parse :: a -> Parser a i b
parse x = \good bad -> good x

ap :: Parser (a->b) i c -> Parser a i c -> Parser b i c
ap     x y = \good bad ->
                x       (\u -> y (\v -> let uv = u v in seq uv (good uv) ) bad)
                        bad

chk :: Parser b i c -> Parser a i c -> Parser b i c
chk     x y = \good bad ->
                x       (\u -> y (\_ -> good u) bad)
                        bad

into :: Parser a i c -> (a->Parser b i c) -> Parser b i c
into     x y = \good bad ->
                x       (\u -> y u good bad)
                        bad

orelse :: Parser a i b -> Parser a i b -> Parser a i b
x `orelse` y = \good bad input ->
        x good (y good bad input) input

token :: (Show b) => (Pos -> b -> Either String d) -> Parser d [(Pos,b,e,f)] h
token p = \good bad ((pos,t,_,_):input) err ->
        case p pos t of
                Right tt' -> good tt' input err
                Left  f   -> bad (maxError (pos,show t,[f]) err)

parseFail :: Parser a i b
parseFail = \good bad input err -> bad err


maxError :: Ord a => (a, b, [a1]) -> (a, b, [a1]) -> (a, b, [a1])
maxError (a@(pa,ta,ma)) (b@(pb,tb,mb)) =
        if pa > pb then a
        else if pb > pa then b
             else (pa,ta,ma++mb)
