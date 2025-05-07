c This file has been generated automatically by FeynRules

c Version: 2.3.49   Date: 9. 4. 2025,    0:20

c Internal parameters definition :

c Parameters that should not be recomputed event by event.
      if(readlha) then
      FRPi = 3.141592654
      aEW = 1/aEWM1
      sw2 = 1 - MW**2/MZ**2
      ee = 3.5449077018110318*sqrt(aEW)
      cw = sqrt(1. - 1.*sw2)
      sw = sqrt(sw2)
      gw = ee/sw
      g1 = ee/cw
      G = 3.5449077018110318*sqrt(aS)
      vev = (2*MW*sw)/ee
      lam = MH**2/(2.*vev**2)
      muH = sqrt(lam*vev**2)
      ye = (sqrt(2.)*yme)/vev
      ym = (sqrt(2.)*ymm)/vev
      ytau = (sqrt(2.)*ymtau)/vev
      yup = (sqrt(2.)*ymup)/vev
      yc = (sqrt(2.)*ymc)/vev
      yt = (sqrt(2.)*ymt)/vev
      ydo = (sqrt(2.)*ymdo)/vev
      ys = (sqrt(2.)*yms)/vev
      yb = (sqrt(2.)*ymb)/vev
      CKM1x1 = Cos(cabi)
      CKM1x2 = Sin(cabi)
      CKM1x3 = 0
      CKM2x1 = -Sin(cabi)
      CKM2x2 = Cos(cabi)
      CKM2x3 = 0
      CKM3x1 = 0
      CKM3x2 = 0
      CKM3x3 = 1
      Sqrt2 = sqrt(2.)
      SqrtPi = sqrt(FRPi)
      Psw2 = sw**2
      Pcw2 = cw**2
      CONJCKM2x3 = conjg(CKM2x3)
      CONJCKM3x3 = conjg(CKM3x3)
      CONJCKM1x3 = conjg(CKM1x3)
      CONJCKM2x1 = conjg(CKM2x1)
      CONJCKM3x1 = conjg(CKM3x1)
      CONJCKM1x1 = conjg(CKM1x1)
      CONJCKM2x2 = conjg(CKM2x2)
      CONJCKM3x2 = conjg(CKM3x2)
      CONJCKM1x2 = conjg(CKM1x2)
      endif
c Parameters that should be recomputed at an event by even basis.
      ggT1 = sqrt(G**2)


c Definition of the EW coupling used in the write out of aqed
      gal(1) = ee
      gal(2) = ee


c Definition of DUM symbols
      DUM0 = 0
      DUM1 = 1


