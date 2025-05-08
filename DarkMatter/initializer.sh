#!/bin/bash

CARPETA="./DarkMatter_UFO"

if [ ! -d "$CARPETA" ]; then
    echo "Modelo no encontrado. Ejecuntando WolframScript..."
    wolframscript main.wls
else
    echo "Modelo existente. Ejecutando madgraphsim.mg5 ... "
    # Aquí puedes poner los siguientes pasos
    cd ../Libraries/MG5_aMC_v2_9_23/bin
    ./mg5_aMC ../../../DarkMatter/madgraphsim.mg5
fi

echo "OutputMadGraph creado"