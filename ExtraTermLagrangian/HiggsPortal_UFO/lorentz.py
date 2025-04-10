# This file was automatically created by FeynRules 2.3.49
# Mathematica version: 14.2.0 for Mac OS X ARM (64-bit) (December 26, 2024)
# Date: Thu 10 Apr 2025 02:08:33


from object_library import all_lorentz, Lorentz

from function_library import complexconjugate, re, im, csc, sec, acsc, asec, cot
try:
   import form_factors as ForFac 
except ImportError:
   pass


UUS4 = Lorentz(name = 'UUS4',
               spins = [ -1, -1, 1 ],
               structure = '1')

UUV4 = Lorentz(name = 'UUV4',
               spins = [ -1, -1, 3 ],
               structure = 'P(3,2) + P(3,3)')

SSS4 = Lorentz(name = 'SSS4',
               spins = [ 1, 1, 1 ],
               structure = '1')

FFS13 = Lorentz(name = 'FFS13',
                spins = [ 2, 2, 1 ],
                structure = 'ProjM(2,1)')

FFS14 = Lorentz(name = 'FFS14',
                spins = [ 2, 2, 1 ],
                structure = 'ProjP(2,1)')

FFV10 = Lorentz(name = 'FFV10',
                spins = [ 2, 2, 3 ],
                structure = 'Gamma(3,2,1)')

FFV11 = Lorentz(name = 'FFV11',
                spins = [ 2, 2, 3 ],
                structure = 'Gamma(3,2,-1)*ProjM(-1,1)')

FFV12 = Lorentz(name = 'FFV12',
                spins = [ 2, 2, 3 ],
                structure = 'Gamma(3,2,-1)*ProjP(-1,1)')

VSS4 = Lorentz(name = 'VSS4',
               spins = [ 3, 1, 1 ],
               structure = 'P(1,2) - P(1,3)')

VVS4 = Lorentz(name = 'VVS4',
               spins = [ 3, 3, 1 ],
               structure = 'Metric(1,2)')

VVV4 = Lorentz(name = 'VVV4',
               spins = [ 3, 3, 3 ],
               structure = 'P(3,1)*Metric(1,2) - P(3,2)*Metric(1,2) - P(2,1)*Metric(1,3) + P(2,3)*Metric(1,3) + P(1,2)*Metric(2,3) - P(1,3)*Metric(2,3)')

SSSS4 = Lorentz(name = 'SSSS4',
                spins = [ 1, 1, 1, 1 ],
                structure = '1')

VVSS4 = Lorentz(name = 'VVSS4',
                spins = [ 3, 3, 1, 1 ],
                structure = 'Metric(1,2)')

VVVV16 = Lorentz(name = 'VVVV16',
                 spins = [ 3, 3, 3, 3 ],
                 structure = 'Metric(1,4)*Metric(2,3) - Metric(1,3)*Metric(2,4)')

VVVV17 = Lorentz(name = 'VVVV17',
                 spins = [ 3, 3, 3, 3 ],
                 structure = 'Metric(1,4)*Metric(2,3) + Metric(1,3)*Metric(2,4) - 2*Metric(1,2)*Metric(3,4)')

VVVV18 = Lorentz(name = 'VVVV18',
                 spins = [ 3, 3, 3, 3 ],
                 structure = 'Metric(1,4)*Metric(2,3) - Metric(1,2)*Metric(3,4)')

VVVV19 = Lorentz(name = 'VVVV19',
                 spins = [ 3, 3, 3, 3 ],
                 structure = 'Metric(1,3)*Metric(2,4) - Metric(1,2)*Metric(3,4)')

VVVV20 = Lorentz(name = 'VVVV20',
                 spins = [ 3, 3, 3, 3 ],
                 structure = 'Metric(1,4)*Metric(2,3) - (Metric(1,3)*Metric(2,4))/2. - (Metric(1,2)*Metric(3,4))/2.')

