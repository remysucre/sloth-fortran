{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE ViewPatterns #-}

module Lib where

import Language.Fortran.AST
import Data.Generics.Uniplate.Data
import FQQ

testj :: ProgramFile A0 -> [Block A0]
testj p = [r | r@[fortran| do mildsloth
    wildsloth
  enddo
 |] <- universeBi p]
