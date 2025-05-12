#!/bin/bash


# URLs de los archivos
URL1="https://root.cern/files/HiggsTauTauReduced/DYJetsToLL.root"
URL2="https://root.cern/files/HiggsTauTauReduced/Run2012B_TauPlusX.root"

# Descargar en paralelo
curl -O "$URL1" &
curl -O "$URL2" &

# Esperar a que ambas descargas terminen
wait

mv DYJetsToLL.root ./Datasets/Background/
mv Run2012B_TauPlusX.root ./Datasets/CMS/

echo "Descargas completadas."