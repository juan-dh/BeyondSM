# CMMSW Files

Esta carpeta contiene los archivos y las instrucciones para crear el contenedor de CMSSW 10.6.30. También contiene los pasos del cmsDriver del 0 al 5. Estos se pueden ejecutar *dentro del contenedor* usando el archivo bash `cmsDriverChain.sh`.

El archivo `cmsswInitializer.sh` crea alguna variables utiles que tienen directorios frecuentes, inicia el entorno de CMSSW y se encarga que todos los archivos necesarios esten disponibles.

⚠️ Asegurarse de que los contenedores de Docker tengan acceso a mas de 2GB de RAM.

## Docker


### Creación de la imagen

```
DIR_VOLUME = /mnt/c/Users/harod/Projects/ProyectoAltasEnergias/
DIR_SFILES = /mnt/ArchivosCompartidos
docker run -it --name my_cmssw -v $DIR_VOLUME:$DIR_SFILES 56ef1955c399
```

### Copiar el archivo lhe

```
cp /mnt/ArchivosCompartidos/BeyondSM/DarkMatter/OutputMadGraph/Events/run_01/unweighted_events.lhe.gz .

gunzip unweighted_events.lhe.gz
```

### Copiar la cadena de pasos de cmsDriver

```
cp /mnt/ArchivosCompartidos/BeyondSM/DarkMatter/CMSSWFiles/cmsDriverChain.sh .
```

### Enviroment en CMSSW

```
cmsenv
```

Todos los pasos anteriores estan encapsulados en cmsswInitializer.sh. Ejecutar con *source* para tener todo listo.

## Pasos de cmsDriver

### Step 0
```
cmsDriver.py step0 \
--filein file:unweighted_events.lhe \
--fileout file:LHE-13TeV.root \
--mc \
--eventcontent LHE \
--datatier GEN \
--conditions 106X_mcRun2_asymptotic_v17 \
--step NONE \
--python_filename LHE_13TeV_cfg.py \
--no_exec \
--customise Configuration/DataProcessing/Utils.addMonitoring \
-n 100

cmsRun LHE_13TeV_cfg.py
```

### Step 1 GEN-SIM

```
cmsDriver.py Configuration/Generator/python/Hadronizer_TuneCUETP8M1_13TeV_generic_LHE_pythia8_cff.py \
--filein file:LHE-13TeV.root \
--fileout file:GENSIM-13TeV.root \
--mc \
--eventcontent RAWSIM \
--datatier GEN-SIM \
--conditions 106X_mcRun2_asymptotic_v17 \
--beamspot Realistic25ns13TeV2016Collision \
--step GEN,SIM \
--nThreads 4 \
--geometry DB:Extended \
--era Run2_2016 \
--python_filename GENSIM_13TeV_cfg.py \
--no_exec \
--customise Configuration/DataProcessing/Utils.addMonitoring \
-n 100

cmsRun GENSIM_13TeV_cfg.py
```

### Step 2 DIGI-

```
cmsDriver.py step2 \
--mc \
--eventcontent RAWSIM \
--datatier GEN-SIM-DIGI-RAW \
--conditions 106X_mcRun2_asymptotic_v17 \
--step DIGI,L1,DIGI2RAW,HLT:@relval2016 \
--nThreads 4 \
--geometry DB:Extended \
--era Run2_2016 \
--python_filename step2_digi_mix_L1_HLT.py \
--no_exec \
--filein file:GENSIM-13TeV.root \
--fileout=digiHLT.root \
--customise Configuration/DataProcessing/Utils.addMonitoring \
-n 100

cmsRun step2_digi_mix_L1_HLT.py
```

### Step 3 

```
cmsDriver.py \
--python_filename reco.py \
--eventcontent AODSIM \
--customise Configuration/DataProcessing/Utils.addMonitoring \
--datatier AODSIM \
--fileout file:reco.root \
--conditions 106X_mcRun2_asymptotic_v17 \
--step RAW2DIGI,L1Reco,RECO,RECOSIM \
--nThreads 4 \
--geometry DB:Extended \
--filein file:digiHLT.root \
--era Run2_2016 \
--runUnscheduled \
--no_exec \
--mc \
-n 100

cmsRun reco.py
```

### Step 4

```
cmsDriver.py \
--python_filename pat.py \
--eventcontent MINIAODSIM \
--customise Configuration/DataProcessing/Utils.addMonitoring \
--datatier MINIAODSIM \
--fileout file:pat.root \
--conditions 106X_mcRun2_asymptotic_v17 \
--step PAT \
--procModifiers run2_miniAOD_UL \
--nThreads 4 \
--geometry DB:Extended \
--filein file:reco.root \
--era Run2_2016 \
--runUnscheduled \
--no_exec \
--mc \
-n 100

cmsRun pat.py
```

### Step 5

```
cmsDriver.py \
--filein file:pat.root \
--fileout file:NanoAOD.root \
--mc \
--eventcontent NANOAODSIM \
--datatier NANOAODSIM \
--conditions 106X_mcRun2_asymptotic_v17 \
--step NANO \
--nThreads 4 \
--geometry DB:Extended \
--era Run2_2016,run2_nanoAOD_94X2016 \
--python_filename nanoAOD_cfg.py \
--no_exec \
--customise_commands 'process.nanoAOD_step *= process.nanoSequenceMC' \
-n 100

cmsRun nanoAOD_cfg.py
```

## Archivos `.root`

Copia el archivo ROOT del paso NANO al volumen para analizarlo desde el contenedor de Analisis de datos

```
cp NanoAOD.root /mnt/ArchivosCompartidos/BeyondSM/DarkMatter/ROOTFiles/
```