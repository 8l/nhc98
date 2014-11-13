module Parse.Parse2
  ( parseConstr,  parseContexts, parseDeriving, parseFixDecls
  , parseFixDecl, parseImpDecls, parseInst,     parseSimple, parseType
  , parseExports, parseStrict,   parsePragma
  , bigModId
  ) where

import Util.Extra(pair,triple)
import Parse.Lex hiding (TokenId)
import Syntax hiding (TokenId)
import Parse.LexPre (PosTokenPre)
import Parse.Lexical (PosToken, LexState)
import MkSyntax
import Parse.ParseLib
import Parse.ParseLex
import SyntaxPos
import TokenId(t_Arrow,TokenId(..))
import SysDeps (packString,unpackPS)

parseExports :: Parser (Maybe [Export TokenId]) [PosToken] b
parseExports =
    Just `parseChk` lpar `apCut` manySep comma parseExport `chk` 
      optional comma `chk` rpar
        `orelse`
    parse Nothing `chk` (lit (L_ACONID (TupleId 0))
                            `orelse`
                         lit (L_ACONID (TupleId 2)))
        `orelse`
    parse (Just [])

parseExport :: Parser (Export TokenId) [(Pos, Lex, Parse.Lexical.LexState, [Parse.LexPre.PosTokenPre])] b
parseExport =
    (uncurry ExportModid) `parseChk` lit L_module `apCut` bigModId      -- 1.3
        `orelse`
 -- (uncurry ExportModid) `parseAp` aconid `chk` dotdot                 -- 1.2
 --     `orelse`
    (\e -> ExportEntity (getPos e) e) `parseAp` parseEntity

parseImpDecls :: Parser [ImpDecl TokenId] [PosToken] c
parseImpDecls =
    manysSep semi parseImpDecl

parseImpDecl :: Parser (ImpDecl TokenId) [(Pos, Lex, LexState, [PosTokenPre])] b
parseImpDecl =
    Importas `parseChk` lit L_import `ap` bigModId
                    `chk` k_as `ap` bigModId `ap` parseImpSpec   -- added in H98
        `orelse`
    importas `parseChk` lit L_import `ap` aconid `ap` parseImpSpec
        `orelse`
    ImportQas `parseChk` lit L_import `chk` k_qualified `ap` bigModId
                    `chk` k_as `ap` bigModId `ap` parseImpSpec
        `orelse`
    importQas `parseChk` lit L_import `chk` k_qualified
                    `ap` aconid `ap` parseImpSpec     -- impSpec is FAKE
  where
    importas  m@(p,Visible _)     s = Import m s
    importas  m@(p,Qualified a b) s = Import (deQualify m) s
 -- importas  m@(p,Qualified a b) s = Importas (deQualify m) (p,Visible b) s
    importQas m@(p,Visible _)     s = ImportQ m s
    importQas m@(p,Qualified a b) s = ImportQ (deQualify m) s
 -- importQas m@(p,Qualified a b) s = ImportQas (deQualify m) (p,Visible b) s

bigModId :: Parser (Pos, TokenId) [(Pos, Lex, e, f)] c
bigModId = deQualify `parseAp` aconid

deQualify :: (a, TokenId) -> (a, TokenId)
deQualify m@(pos,Visible _)     = m
deQualify   (pos,Qualified a b) = (pos, (Visible . packString . concat)
                                                  [unpackPS b,".",unpackPS a])


parseImpSpec :: Parser (ImpSpec TokenId) [PosToken] b
parseImpSpec =
    (NoHiding []) `parseChk` (k_unit `orelse` lit (L_ACONID (TupleId 2)))
                        -- fix for  import Module()  and  import Module (,)
        `orelse`
    NoHiding `parseChk` lpar `apCut` manySep comma parseEntity `chk` 
      optional comma `chk` rpar
        `orelse`
    Hiding `parseChk` k_hiding `chk` lpar `apCut`
      manySep comma parseEntity `chk` optional comma `chk` rpar
        `orelse`
    (Hiding []) `parseChk` k_hiding `chk` (k_unit `orelse`
                                           lit (L_ACONID (TupleId 2)))
                        -- fix for  hiding ()  and  hiding (,)
        `orelse`
    parse (Hiding [])

parseEntity :: Parser (Entity TokenId) [(Pos, Lex, LexState, [PosTokenPre])] b
parseEntity =
    (uncurry EntityConClsAll) `parseAp` aconid `chk`
                                lpar `chk` dotdot `chk` rpar
        `orelse`
    (\(pos,x) -> EntityConClsSome pos x []) `parseAp` aconid `chk` tuple0
        `orelse`
    (uncurry EntityConClsSome) `parseAp` aconid `chk`
                lpar `ap` (manySep comma (conid `orelse` varid)) `chk` rpar
        `orelse`
    (uncurry EntityConClsSome) `parseAp` aconid `ap` (parse [])
	`orelse`
    (uncurry EntityVar) `parseAp` varid


parseFixDecls :: Parser [(InfixClass TokenId, Int, [FixId TokenId])] [PosToken] b
parseFixDecls =
    semi `revChk` parseFixDecls
        `orelse`
    manysSep semi parseFixDecl

defint :: Int -> Parser Int [(Pos, Lex, e, f)] b
defint d =
    intPrim
        `orelse`
    parse d

parseInfix :: Parser (InfixClass a) [(Pos, Lex, e, f)] b
parseInfix = InfixL `parseChk` lit L_infixl
               `orelse`
             InfixR `parseChk` lit L_infixr
               `orelse`
             Infix  `parseChk` lit L_infix

parseFixDecl :: Parser (InfixClass TokenId, Int, [FixId TokenId]) [(Pos, Lex, LexState, [PosTokenPre])] b
parseFixDecl =
        triple `parseAp` parseInfix `ap` defint 9 `ap` someSep comma parseFixId
               `orelse`
        k_prefix `into` \ _ -> varid `into` \ (p,v) -> defint 9 `into` \ l -> parseFixId `into` \ fid ->
        parse (InfixPre v,l,[fid])

parseFixId :: Parser (FixId TokenId) [(Pos, Lex, LexState, [PosTokenPre])] b
parseFixId = 
        (uncurry FixCon) `parseAp` conop
            `orelse`
        (uncurry FixVar) `parseAp` varop


parseType :: Parser (Type TokenId) [PosToken] b
parseType = 
    parseBType  `into` parseCType
                `into` \ t1 -> (
                    (\ pos t2 -> TypeCons pos t_Arrow [t1,t2]) `parseAp` rarrow `apCut` parseType
                        `orelse`
                    parse t1)

parseCType :: Type TokenId -> Parser (Type TokenId) [PosToken] b
parseCType t1 = 
    parseAType `into` (\ t2 -> parseCType (TypeApp t1 t2))
        `orelse`
    parse t1

parseBType :: Parser (Type TokenId) [PosToken] b
parseBType  = 
    ( \ (pos,c) ts -> TypeCons pos c ts) `parseAp` conid `ap` some parseAType
        `orelse`
    parseAType

parseAType :: Parser (Type TokenId) [PosToken] b
parseAType = 
    (uncurry TypeVar) `parseAp` varid
        `orelse`
    (\(pos,c) -> TypeCons pos c []) `parseAp` conid
        `orelse`
    mkParType `parseAp` lpar `apCut` manySep comma parseType `chk` rpar
        `orelse`
    mkTypeList `parseAp` lbrack `apCut` parseType `chk` rbrack
    

parseContexts :: Parser [Context TokenId] [PosToken] b
parseContexts =
    lpar `revChk` manySep comma parseContext `chk` rpar `chk` impl
        `orelse`
    (:[]) `parseAp` parseContext `chk` impl
        `orelse`
    parse [] `chk` tuple0 `chk` impl
        `orelse`
    parse []

parseContext :: Parser (Context TokenId) [(Pos, Lex, LexState, [PosTokenPre])] c
parseContext = 
    (\ (pos,c) pt_t -> Context pos c pt_t)  `parseAp` conid `ap` some varid

parseSimple :: Parser (Simple TokenId) [PosToken] c
parseSimple =
    (uncurry Simple) `parseAp` conid `ap` many varid

parseConstr :: Parser (Constr TokenId) [PosToken] b
parseConstr =
        (k_forall `revChk` some varid `into` \ free -> k_dot `revChk` parseConstr' free)
          `orelse`
        parseConstr' []

parseConstr' :: [(Pos, TokenId)] -> Parser (Constr TokenId) [PosToken] b
parseConstr' free =
    (\a (pos,op) b -> (if null free 
                       then Constr pos op [a,b]
                       else ConstrCtx free [] pos op [a,b]))
                         `parseAp` parseOneFieldType `ap` conop `ap` parseOneFieldType
        `orelse`
    (\ctxs (pos,op) a ->
        case ctxs of
           [] ->  (if null free 
                   then Constr            pos op (concat a)
                   else ConstrCtx free [] pos op (concat a))
           _  ->  ConstrCtx free ctxs pos op (concat a)) `parseAp` parseContexts 
                                                         `ap` conid `ap` many parseManyFieldType

parseOneFieldType :: Parser (Maybe [(Pos, TokenId)], Type TokenId) [PosToken] b
parseOneFieldType =
     (\ field typ -> (Just [field],typ)) `parseChk` lcurl `apCut` varid `chk` coloncolon `ap` parseSBType `chk` rcurl 
        `orelse`
     (pair Nothing) `parseAp` parseSBType


parseManyFieldType :: Parser [(Maybe [(Pos, TokenId)], Type TokenId)] [PosToken] b
parseManyFieldType =
     lcurl `into` (\ _ -> manySep comma parseManyFieldType' `chk` rcurl)  -- { v1,...,v2::typeN , ...  w1,...,wN::typeN } 
        `orelse`
     ((:[]).pair Nothing) `parseAp` (parseStrict parseAType)

parseManyFieldType' :: Parser (Maybe [(Pos, TokenId)], Type TokenId) [PosToken] c
parseManyFieldType' =
     (\ fields typ -> (Just fields,typ)) `parseAp` someSep comma varid `chk` coloncolon `ap`  parseSBType  -- v1,...,v2::typeN 

parseSBType :: Parser (Type TokenId) [PosToken] b
parseSBType =
    parseStrict parseType
        `orelse`
    parseType

parseStrict :: Parser (Type id) [PosToken] b 
            -> Parser (Type id) [PosToken] b
parseStrict p =
  TypeStrict `parseAp` bang `ap` p
        `orelse`
  p

parseDeriving :: Parser [(Pos, TokenId)] [PosToken] b
parseDeriving =
    lit L_deriving `revChk` lpar `revChk` manySep comma conid `chk` rpar
        `orelse`
    parse [] `chk` lit L_deriving `chk` tuple0
        `orelse`
    (:[]) `parseChk` lit L_deriving `apCut` conid
        `orelse`
    parse []

{- The following code parses Haskell'98 instance heads.
-- H'98 is much more restrictive about the possible types in an instance
-- than MPTC with fundeps.
parseInst =
    (\ (p,c) -> TypeCons p c []) `parseAp` conid  -- type without arguments
        `orelse`
    lpar `revChk` parseInst' `chkCut` rpar        -- type inside parenthesis
        `orelse`
    (\p (_,pat) -> mkInstList p pat) `parseAp` lbrack `apCut` varid
                                     `chk` rbrack -- the list type

parseInst' =
    lpar `revChk` parseInst' `chkCut` rpar        -- useless extra parenthesis
        `orelse`
    varid `revAp` ((\pos (pa,a) (pb,b) ->
                        TypeCons pos t_Arrow [TypeVar pb b,TypeVar pa a])
                                             `parseAp` rarrow `apCut` varid
                      `orelse`
                   (\a b@(p,_) -> mkParInst p (b:a)) `parseChk` comma
                                             `apCut` someSep comma varid
                  )
        `orelse`
    mkAppInst `parseAp` conid `ap` many varid
        `orelse`
    (\pos-> TypeCons pos t_Arrow []) `parseAp` k_rarrow
        `orelse`
--    (TypeCons noPos (t_Tuple 0) []) `parseChk` lpar `chk` rpar
--        `orelse`
    parse (TypeCons noPos (t_Tuple 0) [])
-}
parseInst :: Parser (Type TokenId) [PosToken] b
parseInst = parseAType

parsePragma :: Parser (Decl id) [PosToken] c
parsePragma =
     DeclIgnore "PRAGMA" `parseChk`  lannot `chk`
                                     many notRannot `chk` rannot

{- possible extension for when we want to use pragmas in nhc98 -}
--parsePragma =
--     DeclPragma `parseChk`  lannot `ap` conid `chk`
--                            ("" `parseChk` many notRannot) `chk` rannot
