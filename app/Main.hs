module Main where

import Lib
import Language.Fortran.PrettyPrint
import Language.Fortran.AST
import Language.Fortran.ParserMonad
import Language.Fortran.Parser.Fortran90
import qualified Data.ByteString as BS
import System.Environment
import Debug.Trace

main :: IO ()
main = do
  [fn] <- getArgs
  fc <- BS.readFile fn
  -- TODO update to call the right parser
  let fortran = case fortran90Parser fc fn
                  of ParseOk pt _ -> traceShowId pt
                     _ -> trace fn $ ProgramFile (MetaInfo Fortran90 "") []
      res = testj fortran
      prettyPrint = \r -> pprintAndRender Fortran90 r fixedForm
      ms = concatMap ((++ "haha \n") . prettyPrint) $ res
      out = fn ++ "\n" ++ ms ++ "matches" ++ (show $ length res) ++ "\n"
  if length res > 0 then putStr out else return ()
