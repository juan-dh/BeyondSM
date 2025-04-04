# This file was automatically created by FeynRules 2.3.49
# Mathematica version: 14.2.0 for Mac OS X ARM (64-bit) (December 26, 2024)
# Date: Fri 4 Apr 2025 16:42:02


from __future__ import division
from object_library import all_particles, Particle
import parameters as Param

import propagators as Prop

phi = Particle(pdg_code = 9000001,
               name = 'phi',
               antiname = 'phi',
               spin = 1,
               color = 1,
               mass = Param.Mphi,
               width = Param.ZERO,
               texname = 'phi',
               antitexname = 'phi',
               charge = 0)

