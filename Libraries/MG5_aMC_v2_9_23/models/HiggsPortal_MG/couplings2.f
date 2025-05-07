      subroutine coup2(readlha)

      implicit none
      logical readlha

      include 'input.inc'
      include 'coupl.inc'
      include 'intparam_definition.inc'


c Interactions associated with 2
      if(readlha) then
      MGVX10 = ee
      MGVX42 = (cw*ee)/sw
      MGVX67 = ee**2
      MGVX68 = (cw*ee**2)/sw
      MGVX75 = -(ee**2/Psw2)
      MGVX76 = (ee**2*Pcw2)/Psw2

      MGVX22 = -6*lam*vev
      MGVX70 = -6*lam
      MGVX73 = -2*lamHS
      MGVX74 = lamS
      MGVX28 = (ee**2*vev)/(2.*Psw2)
      MGVX29 = ee**2*vev + (ee**2*Pcw2*vev)/(2.*Psw2) + (ee**2*Psw2
     +*vev)/(2.*Pcw2)
      MGVX71 = ee**2/(2.*Psw2)
      MGVX72 = ee**2 + (ee**2*Pcw2)/(2.*Psw2) + (ee**2*Psw2)/(2.*Pc
     +w2)

      MGVX4(1) = ee
      MGVX4(2) = ee
      MGVX21(1) = -(ye/Sqrt2)
      MGVX21(2) = -(ye/Sqrt2)
      MGVX23(1) = -(ym/Sqrt2)
      MGVX23(2) = -(ym/Sqrt2)
      MGVX25(1) = -(ytau/Sqrt2)
      MGVX25(2) = -(ytau/Sqrt2)
      MGVX39(1) = -(ee/(Sqrt2*sw))
      MGVX39(2) = 0
      MGVX58(1) = (cw*ee)/(2.*sw) - (ee*sw)/(2.*cw)
      MGVX58(2) = -((ee*sw)/cw)
      MGVX64(1) = -0.5*(cw*ee)/sw - (ee*sw)/(2.*cw)
      MGVX64(2) = 0
      MGVX1(1) = ee/3.
      MGVX1(2) = ee/3.
      MGVX2(1) = (-2*ee)/3.
      MGVX2(2) = (-2*ee)/3.
      MGVX18(1) = -(yb/Sqrt2)
      MGVX18(2) = -(yb/Sqrt2)
      MGVX19(1) = -(yc/Sqrt2)
      MGVX19(2) = -(yc/Sqrt2)
      MGVX20(1) = -(ydo/Sqrt2)
      MGVX20(2) = -(ydo/Sqrt2)
      MGVX24(1) = -(ys/Sqrt2)
      MGVX24(2) = -(ys/Sqrt2)
      MGVX26(1) = -(yt/Sqrt2)
      MGVX26(2) = -(yt/Sqrt2)
      MGVX27(1) = -(yup/Sqrt2)
      MGVX27(2) = -(yup/Sqrt2)
      MGVX30(1) = -((CKM2x3*ee)/(Sqrt2*sw))
      MGVX30(2) = 0
      MGVX31(1) = -((CKM2x1*ee)/(Sqrt2*sw))
      MGVX31(2) = 0
      MGVX32(1) = -((CKM2x2*ee)/(Sqrt2*sw))
      MGVX32(2) = 0
      MGVX33(1) = -((CKM3x3*ee)/(Sqrt2*sw))
      MGVX33(2) = 0
      MGVX34(1) = -((CKM3x1*ee)/(Sqrt2*sw))
      MGVX34(2) = 0
      MGVX35(1) = -((CKM3x2*ee)/(Sqrt2*sw))
      MGVX35(2) = 0
      MGVX36(1) = -((CKM1x3*ee)/(Sqrt2*sw))
      MGVX36(2) = 0
      MGVX37(1) = -((CKM1x1*ee)/(Sqrt2*sw))
      MGVX37(2) = 0
      MGVX38(1) = -((CKM1x2*ee)/(Sqrt2*sw))
      MGVX38(2) = 0
      MGVX43(1) = -((CONJCKM2x3*ee)/(Sqrt2*sw))
      MGVX43(2) = 0
      MGVX44(1) = -((CONJCKM3x3*ee)/(Sqrt2*sw))
      MGVX44(2) = 0
      MGVX45(1) = -((CONJCKM1x3*ee)/(Sqrt2*sw))
      MGVX45(2) = 0
      MGVX46(1) = -((CONJCKM2x1*ee)/(Sqrt2*sw))
      MGVX46(2) = 0
      MGVX47(1) = -((CONJCKM3x1*ee)/(Sqrt2*sw))
      MGVX47(2) = 0
      MGVX48(1) = -((CONJCKM1x1*ee)/(Sqrt2*sw))
      MGVX48(2) = 0
      MGVX51(1) = -((CONJCKM2x2*ee)/(Sqrt2*sw))
      MGVX51(2) = 0
      MGVX52(1) = -((CONJCKM3x2*ee)/(Sqrt2*sw))
      MGVX52(2) = 0
      MGVX53(1) = -((CONJCKM1x2*ee)/(Sqrt2*sw))
      MGVX53(2) = 0
      MGVX55(1) = (cw*ee)/(2.*sw) + (ee*sw)/(6.*cw)
      MGVX55(2) = -0.3333333333333333*(ee*sw)/cw
      MGVX56(1) = -0.5*(cw*ee)/sw + (ee*sw)/(6.*cw)
      MGVX56(2) = (2*ee*sw)/(3.*cw)
      endif

      return
      end
