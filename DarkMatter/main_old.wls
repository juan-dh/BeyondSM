#!/usr/bin/env wolframscript

$FeynRulesPath = 
  SetDirectory["~/Documents/ProyectoAE/feynrules-current/"];

<< FeynRules`;

FR$Parallel = False;

SetDirectory["~/Documents/ProyectoAE/code/ExtraTermLagrangian/"]

LoadModel["SM/SM.fr", "HiggsPortal.fr"]

(* LoadRestriction["SM/DiagonalCKM.rst","SM/Massless.rst"]*)

LNew = 1/2 del[Sc, mu] del[Sc, mu] - 1/2 (msc2^2 + lamHS v^2) Sc^2 + 
  lamS/4! Sc^4 - lamHS Sc^2 HC[Phi] . Phi

CheckHermiticity[LNew]

vertices = FeynmanRules[LNew];

WriteUFO[LSM+LNew];

(*FeynmanGauge = False;
WriteMGOutput[LGauge, LFermions, LHiggs, LYukawa, LNew];
*)
