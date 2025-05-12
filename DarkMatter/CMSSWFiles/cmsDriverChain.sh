#!/bin/bash
exec > >(tee -a chain.log)
exec 2>&1

echo "Number of events: "
read nEvents

echo "Number of threads: "
read nThreads

# STEP 0

echo "========= STEP 0 ========="

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
-n "$nEvents"

cmsRun LHE_13TeV_cfg.py

# STEP 1

echo "========= STEP 1 =========" 

cmsDriver.py Configuration/Generator/python/Hadronizer_TuneCUETP8M1_13TeV_generic_LHE_pythia8_cff.py \
--filein file:LHE-13TeV.root \
--fileout file:GENSIM-13TeV.root \
--mc \
--eventcontent RAWSIM \
--datatier GEN-SIM \
--conditions 106X_mcRun2_asymptotic_v17 \
--beamspot Realistic25ns13TeV2016Collision \
--step GEN,SIM \
--nThreads "$nThreads" \
--geometry DB:Extended \
--era Run2_2016 \
--python_filename GENSIM_13TeV_cfg.py \
--no_exec \
--customise Configuration/DataProcessing/Utils.addMonitoring \
-n "$nEvents"

cmsRun GENSIM_13TeV_cfg.py

# STEP 2

echo "========= STEP 2 ========="

cmsDriver.py step2 \
--mc \
--eventcontent RAWSIM \
--datatier GEN-SIM-DIGI-RAW \
--conditions 106X_mcRun2_asymptotic_v17 \
--step DIGI,L1,DIGI2RAW,HLT:@relval2016 \
--nThreads "$nThreads" \
--geometry DB:Extended \
--era Run2_2016 \
--python_filename DIGI_mix_L1_HLT_13TeV_cfg.py \
--no_exec \
--filein file:GENSIM-13TeV.root \
--fileout=DIGI_mix_L1_HLT_13TeV.root \
--customise Configuration/DataProcessing/Utils.addMonitoring \
-n "$nEvents"

cmsRun DIGI_mix_L1_HLT_13TeV_cfg.py

# STEP 3

echo "========= STEP 3 ========="

cmsDriver.py \
--python_filename RECO_13TeV_cfg.py \
--eventcontent AODSIM \
--customise Configuration/DataProcessing/Utils.addMonitoring \
--datatier AODSIM \
--fileout file:RECO_13TeV.root \
--conditions 106X_mcRun2_asymptotic_v17 \
--step RAW2DIGI,L1Reco,RECO,RECOSIM \
--nThreads "$nThreads" \
--geometry DB:Extended \
--filein file:DIGI_mix_L1_HLT_13TeV.root \
--era Run2_2016 \
--runUnscheduled \
--no_exec \
--mc \
-n "$nEvents"

cmsRun RECO_13TeV_cfg.py

# STEP 4

echo "========= STEP 4 =========" 

cmsDriver.py \
--python_filename PAT_13TeV_cfg.py \
--eventcontent MINIAODSIM \
--customise Configuration/DataProcessing/Utils.addMonitoring \
--datatier MINIAODSIM \
--fileout file:PAT_13TeV.root \
--conditions 106X_mcRun2_asymptotic_v17 \
--step PAT \
--procModifiers run2_miniAOD_UL \
--nThreads "$nThreads" \
--geometry DB:Extended \
--filein file:RECO_13TeV.root \
--era Run2_2016 \
--runUnscheduled \
--no_exec \
--mc \
-n "$nEvents"

cmsRun PAT_13TeV_cfg.py

# STEP 5

echo "========= STEP 5 ========="

cmsDriver.py \
--filein file:PAT_13TeV.root \
--fileout file:NanoAOD.root \
--mc \
--eventcontent NANOAODSIM \
--datatier NANOAODSIM \
--conditions 106X_mcRun2_asymptotic_v17 \
--step NANO \
--nThreads "$nThreads" \
--geometry DB:Extended \
--era Run2_2016,run2_nanoAOD_94X2016 \
--python_filename NanoAOD_13TeV_cfg.py \
--no_exec \
--customise_commands 'process.nanoAOD_step *= process.nanoSequenceMC' \
-n "$nEvents"

cmsRun NanoAOD_13TeV_cfg.py

echo "========= CHAIN COMPLETED ========="