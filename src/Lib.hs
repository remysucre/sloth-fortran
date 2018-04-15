{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE ViewPatterns #-}

module Lib where

import Language.Fortran.AST
import Language.Fortran.Util.Position
import Data.Generics.Uniplate.Data
import Debug.Trace
import FQQ

testj :: ProgramFile A0 -> [Block A0]
testj p = [ r | (r, c) <- contextsBi p, pat r && lhs r && noCondBl r && noCond r && pctxt (c smark)]
  where
        pat [fortran| do mildsloth
                         wildsloth
                      enddo
                    |] = True
        pat _ = False
        noCond x = null [ undefined | s  <- universeBi x, isif s ]
        noCondBl x = null [ undefined | s  <- universeBi x, isifbl s ]
        isifbl (BlIf () _ _ _ _ _ _) = True
        isifbl _ = False
        isif (StIfLogical () _ _ _) = True
        isif _ = False
        lhs x = null [ r | r@(StExpressionAssign () _ l _) <- universeBi x, array l]
        array x = not $ null [ i::Index () | i <- universeBi x, index i]
        index (IxSingle () _ Nothing (ExpValue () _ (ValVariable _))) = False
        index _ = True
        pctxt n = [ x | x <- [c::Block A0 | c@[fortran| do mildsloth
                                                           wildsloth
                                                        enddo
                                                      |] <- universeBi n] , marked x ] == []
        marked x = [ blc::Block A0 | blc@[fortran|!lazysloth
                                                 |] <- universeBi x ] /= []

smark :: Block A0
smark = BlComment () initSrcSpan (Comment "lazysloth")
