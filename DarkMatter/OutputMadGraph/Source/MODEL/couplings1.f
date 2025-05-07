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
      GC_77 = (MDL_EE*MDL_COMPLEXI*MDL_SW)/(3.000000D+00*MDL_CW)
      GC_78 = (-2.000000D+00*MDL_EE*MDL_COMPLEXI*MDL_SW)/(3.000000D+00
     $ *MDL_CW)
      GC_79 = (MDL_EE*MDL_COMPLEXI*MDL_SW)/MDL_CW
      GC_81 = -5.000000D-01*(MDL_CW*MDL_EE*MDL_COMPLEXI)/MDL_SW
     $ -(MDL_EE*MDL_COMPLEXI*MDL_SW)/(6.000000D+00*MDL_CW)
      GC_82 = (MDL_CW*MDL_EE*MDL_COMPLEXI)/(2.000000D+00*MDL_SW)
     $ -(MDL_EE*MDL_COMPLEXI*MDL_SW)/(6.000000D+00*MDL_CW)
      GC_83 = -5.000000D-01*(MDL_CW*MDL_EE*MDL_COMPLEXI)/MDL_SW
     $ +(MDL_EE*MDL_COMPLEXI*MDL_SW)/(2.000000D+00*MDL_CW)
      GC_92 = -(MDL_COMPLEXI*MDL_LAMS*MDL_VEV)
      GC_104 = MDL_EE__EXP__2*MDL_COMPLEXI*MDL_VEV+(MDL_CW__EXP__2
     $ *MDL_EE__EXP__2*MDL_COMPLEXI*MDL_VEV)/(2.000000D+00
     $ *MDL_SW__EXP__2)+(MDL_EE__EXP__2*MDL_COMPLEXI*MDL_SW__EXP__2
     $ *MDL_VEV)/(2.000000D+00*MDL_CW__EXP__2)
      GC_109 = -((MDL_COMPLEXI*MDL_YC)/MDL_SQRT__2)
      GC_112 = -((MDL_COMPLEXI*MDL_YDO)/MDL_SQRT__2)
      GC_125 = -((MDL_COMPLEXI*MDL_YS)/MDL_SQRT__2)
      GC_136 = -((MDL_COMPLEXI*MDL_YUP)/MDL_SQRT__2)
      END
