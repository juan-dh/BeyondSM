#!/usr/bin/env wolframscript

$FeynRulesPath = 
  SetDirectory[Directory[] <>
  "/../feynrules-current/"];

<< FeynRules`;

FR$Parallel = False;

SetDirectory[Directory[]]

LoadModel["SM/SM.fr", "HiggsPortal.fr"]

(* LoadRestriction["SM/DiagonalCKM.rst","SM/Massless.rst"]*)

(*ExpandIndices[(Phi[1] HC[Phi][1]+Phi[2] HC[Phi][2])]*)

LNew = 1/2 del[Sc, mu] del[Sc, mu] - 1/2 (mSc^2) Sc^2 - 
  1/2 lamS vev  H Sc^2 - 1/4 lamS H^2 Sc^2 - 1/4 lam4 Sc^4

CheckHermiticity[LNew];

vertices = FeynmanRules[LNew];

vertices

WriteUFO[LSM + LNew];
