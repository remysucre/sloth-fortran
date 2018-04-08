{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE ViewPatterns #-}

module Lib where

import Language.Fortran.AST
import Language.Fortran.Util.Position
import Data.Generics.Uniplate.Data
-- import Debug.Trace
import FQQ

testj :: ProgramFile A0 -> [Block A0]
testj p = [r | (r, c) <- contextsBi p, pat r && pctxt (c smark)]
  where
        pat [fortran| do mildsloth
                         wildsloth
                      enddo
                    |] = True
        pat _ = False
        pctxt n = [ x | x <- [c::Block A0 | c@[fortran| do mildsloth
                                                           wildsloth
                                                        enddo
                                                      |] <- universeBi n] , marked x  ] == []
        marked x = [ blc::Block A0 | blc@[fortran|!lazysloth
                                                 |] <- universeBi x ] /= []

smark :: Block A0
smark = BlComment () initSrcSpan (Comment "lazysloth")
