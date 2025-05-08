#!/bin/bash

export DIR_SFILES = /mnt/ArchivosCompartidos
export DIR_SRC = /code/CMSSW_10_6_30/src
export DIR_DM = /mnt/ArchivosCompartidos/BeyondSM/DarkMatter/

echo "Entorno de CMSSW configurado:"
echo "  DIR_SFILES   = $DIR_SFILES"
echo "  DIR_SRC = $DIR_SRC"
echo "  DIR_DM   = $DIR_DM"

cd $DIR_SRC
cp "$DIR_DM/OutputMadGraph/Events/run_01/unweighted_events.lhe.gz" "$DIR_SRC"
gunzip unweighted_events.lhe.gz
cp "$DIR_DM/CMSSWFiles/cmsDriverChain.sh" "$DIR_SRC"
eval `scram runtime -sh`
