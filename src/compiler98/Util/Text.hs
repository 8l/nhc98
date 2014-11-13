{-|
    General text utility functions
-}

module Util.Text where

import Maybe
import Char
import List


trim, trimLeft, trimRight :: String -> String
trim = trimLeft . trimRight
trimLeft = dropWhile isSpace
trimRight = reverse . trimLeft . reverse


isSubstrOf :: Eq a => [a] -> [a] -> Bool
isSubstrOf find list = any (isPrefixOf find) (tails list)


splitList :: Eq a => [a] -> [a] -> [[a]]
splitList find str = if isJust q then a : splitList find b else [str]
    where
        q = splitPair find str
        Just (a, b) = q


splitPair :: Eq a => [a] -> [a] -> Maybe ([a], [a])
splitPair find str = f str
    where
        f [] = Nothing
        f x  | isPrefixOf find x = Just ([], drop (length find) x)
             | otherwise = if isJust q then Just (head x:a, b) else Nothing
                where
                    q = f (tail x)
                    Just (a, b) = q


indexOf :: String -> String -> Int
indexOf find str = length $ takeWhile (not . isPrefixOf (lcase find)) (tails (lcase str))


lcase, ucase :: String -> String
lcase = map toLower
ucase = map toUpper


replace :: Eq a => [a] -> [a] -> [a] -> [a]
replace find with [] = []
replace find with str | find `isPrefixOf` str = with ++ replace find with (drop (length find) str)
                      | otherwise = head str : replace find with (tail str)




-- 0 based return
findNext :: Eq a => [[a]] -> [a] -> Maybe Int
findNext finds str = if null maxs then Nothing else Just (fst (head (sortBy compSnd maxs)))
    where
        maxs = mapMaybe f (zip [0..] finds)
        
        f (id, find) = if isJust q then Just (id, length (fst (fromJust q))) else Nothing
            where q = splitPair find str
        
        compSnd (_, a) (_, b) = compare a b
