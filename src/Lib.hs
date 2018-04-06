{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE ViewPatterns #-}

module Lib where

import Language.Fortran.AST
import Data.Generics.Uniplate.Data
import FQQ

testj :: ProgramFile A0 -> [Block A0]
testj p = [r | r@[fortran| do c=1,number_of_chunks

    if(chunks(c)%task.eq.parallel%task) then

      if(use_fortran_kernels)then
        call pdv_kernel(predict,                  &
                      chunks(c)%field%x_min,      &
                      chunks(c)%field%x_max,      &
                      chunks(c)%field%y_min,      &
                      chunks(c)%field%y_max,      &
                      dt,                         &
                      chunks(c)%field%xarea,      &
                      chunks(c)%field%yarea,      &
                      chunks(c)%field%volume ,    &
                      chunks(c)%field%density0,   &
                      chunks(c)%field%density1,   &
                      chunks(c)%field%energy0,    &
                      chunks(c)%field%energy1,    &
                      chunks(c)%field%pressure,   &
                      chunks(c)%field%viscosity,  &
                      chunks(c)%field%xvel0,      &
                      chunks(c)%field%xvel1,      &
                      chunks(c)%field%yvel0,      &
                      chunks(c)%field%yvel1,      &
                      chunks(c)%field%work_array1 )
      elseif(use_c_kernels)then

        if(predict) then
          prdct=0
        else
          prdct=1
        endif

        call pdv_kernel_c(prdct,                  &
                      chunks(c)%field%x_min,      &
                      chunks(c)%field%x_max,      &
                      chunks(c)%field%y_min,      &
                      chunks(c)%field%y_max,      &
                      dt,                         &
                      chunks(c)%field%xarea,      &
                      chunks(c)%field%yarea,      &
                      chunks(c)%field%volume ,    &
                      chunks(c)%field%density0,   &
                      chunks(c)%field%density1,   &
                      chunks(c)%field%energy0,    &
                      chunks(c)%field%energy1,    &
                      chunks(c)%field%pressure,   &
                      chunks(c)%field%viscosity,  &
                      chunks(c)%field%xvel0,      &
                      chunks(c)%field%xvel1,      &
                      chunks(c)%field%yvel0,      &
                      chunks(c)%field%yvel1,      &
                      chunks(c)%field%work_array1 )
      endif
    endif

  enddo
 |] <- universeBi p]
