ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c      written by the UFO converter
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc

C     Parameters that should not be recomputed event by event.
C     
      IF(READLHA) THEN

        G = 2 * DSQRT(AS*PI)  ! for the first init

        MDL_COMPLEXI = DCMPLX(0.000000D+00,1.000000D+00)

        AS = 1.380000D-01

        G = 4.164300D+00

      ENDIF
C     
C     Parameters that should be recomputed at an event by even basis.
C     
      AS = G**2/4/PI

C     
C     Definition of the EW coupling used in the write out of aqed
C     
      GAL(1) = 1D0
      GAL(2) = 1D0

