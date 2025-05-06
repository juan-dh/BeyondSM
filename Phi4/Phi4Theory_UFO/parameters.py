# This file was automatically created by FeynRules 2.3.49
# Mathematica version: 14.2.0 for Mac OS X ARM (64-bit) (December 26, 2024)
# Date: Wed 16 Apr 2025 01:26:38



from object_library import all_parameters, Parameter


from function_library import complexconjugate, re, im, csc, sec, acsc, asec, cot

# This is a default parameter object representing 0.
ZERO = Parameter(name = 'ZERO',
                 nature = 'internal',
                 type = 'real',
                 value = '0.0',
                 texname = '0')

# User-defined parameters.
lam = Parameter(name = 'lam',
                nature = 'external',
                type = 'real',
                value = 0.1,
                texname = '\\text{lam}',
                lhablock = 'FRBlock',
                lhacode = [ 2 ])

m2 = Parameter(name = 'm2',
               nature = 'external',
               type = 'real',
               value = 1.,
               texname = '\\text{m2}',
               lhablock = 'MASS',
               lhacode = [ 1 ])

Mphi = Parameter(name = 'Mphi',
                 nature = 'external',
                 type = 'real',
                 value = 1,
                 texname = '\\text{Mphi}',
                 lhablock = 'MASS',
                 lhacode = [ 9000001 ])

