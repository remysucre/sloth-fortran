module Lib where

import Language.Fortran.AST
import Data.Generics.Uniplate.Data

testj :: ProgramFile A0 -> [Block A0]
testj p = [r | r@(BlDo _ _ _ _ _ _ _ _) <- universeBi p]
