{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE ViewPatterns #-}

module Lib where

import Language.Fortran.AST
import Data.Generics.Uniplate.Data
import FQQ

testj :: ProgramFile A0 -> [Block A0]
testj = undefined
{-
testj p = [r | r@[fortran| do c = 1, number_of_chunks
        ideal_gas (c, .true.)
      end do |] <- universeBi p]
-}
