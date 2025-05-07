#!/bin/bash

wolframscript main.wls
cd ../Libraries/MG5_aMC_v2_9_23/bin
./mg5_aMC ../../../DarkMatter/mg5file.mg5
