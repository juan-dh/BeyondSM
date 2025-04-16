ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c      written by the UFO converter
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc

      SUBROUTINE COUP1()

      IMPLICIT NONE
      INCLUDE 'model_functions.inc'

      DOUBLE PRECISION PI, ZERO
      PARAMETER  (PI=3.141592653589793D0)
      PARAMETER  (ZERO=0D0)
      INCLUDE 'input.inc'
      INCLUDE 'coupl.inc'
      GC_92 = -(MDL_COMPLEXI*MDL_LAMS*MDL_VEV)
      GC_109 = -((MDL_COMPLEXI*MDL_YC)/MDL_SQRT__2)
      GC_112 = -((MDL_COMPLEXI*MDL_YDO)/MDL_SQRT__2)
      GC_125 = -((MDL_COMPLEXI*MDL_YS)/MDL_SQRT__2)
      GC_136 = -((MDL_COMPLEXI*MDL_YUP)/MDL_SQRT__2)
      END
