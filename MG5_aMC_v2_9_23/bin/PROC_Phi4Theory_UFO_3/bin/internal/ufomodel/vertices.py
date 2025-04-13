# This file was automatically created by FeynRules 2.3.49
# Mathematica version: 14.2.0 for Mac OS X ARM (64-bit) (December 26, 2024)
# Date: Fri 4 Apr 2025 16:31:33


from object_library import all_vertices, Vertex
import particles as P
import couplings as C
import lorentz as L


V_1 = Vertex(name = 'V_1',
             particles = [ P.phi, P.phi, P.phi, P.phi ],
             color = [ '1' ],
             lorentz = [ L.SSSS1 ],
             couplings = {(0,0):C.GC_1})

