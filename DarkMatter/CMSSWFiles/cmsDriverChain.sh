#!/bin/bash

echo "Number of events: "
read nEvents

echo "Number of threads: "
read nThreads

# CMS Environment
echo "======= Setting up CMS environment ========"

cmsenv

# STEP 0

echo "========= STEP 0 ========="
echo "========= STEP 0 =========" > chain.log

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

cmsRun LHE_13TeV_cfg.py >> chain.log 2>&1

# STEP 1

echo "========= STEP 1 =========" 
echo "========= STEP 1 =========" >> chain.log

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

cmsRun GENSIM_13TeV_cfg.py >> chain.log 2>&1

# STEP 2

echo "========= STEP 2 ========="
echo "========= STEP 2 =========" >> chain.log

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

cmsRun step2_digi_mix_L1_HLT.py >> chain.log 2>&1

# STEP 3

echo "========= STEP 3 ========="
echo "========= STEP 3 =========" >> chain.log

cmsDriver.py \
--python_filename reco.py \
--eventcontent AODSIM \
--customise Configuration/DataProcessing/Utils.addMonitoring \
--datatier AODSIM \
--fileout file:reco.root \
--conditions 106X_mcRun2_asymptotic_v17 \
--step RAW2DIGI,L1Reco,RECO,RECOSIM \
--nThreads "$nThreads" \
--geometry DB:Extended \
--filein file:digiHLT.root \
--era Run2_2016 \
--runUnscheduled \
--no_exec \
--mc \
-n "$nEvents"

cmsRun reco.py >> chain.log 2>&1 

# STEP 4

echo "========= STEP 4 =========" 
echo "========= STEP 4 =========" >> chain.log

cmsDriver.py \
--python_filename pat.py \
--eventcontent MINIAODSIM \
--customise Configuration/DataProcessing/Utils.addMonitoring \
--datatier MINIAODSIM \
--fileout file:pat.root \
--conditions 106X_mcRun2_asymptotic_v17 \
--step PAT \
--procModifiers run2_miniAOD_UL \
--nThreads "$nThreads" \
--geometry DB:Extended \
--filein file:reco.root \
--era Run2_2016 \
--runUnscheduled \
--no_exec \
--mc \
-n "$nEvents"

cmsRun pat.py >> chain.log 2>&1

# STEP 5


echo "========= STEP 5 ========="
echo "========= STEP 5 =========" >> chain.log

cmsDriver.py \
--filein file:pat.root \
--fileout file:NanoAOD.root \
--mc \
--eventcontent NANOAODSIM \
--datatier NANOAODSIM \
--conditions 106X_mcRun2_asymptotic_v17 \
--step NANO \
--nThreads "$nThreads" \
--geometry DB:Extended \
--era Run2_2016,run2_nanoAOD_94X2016 \
--python_filename nanoAOD_cfg.py \
--no_exec \
--customise_commands 'process.nanoAOD_step *= process.nanoSequenceMC' \
-n "$nEvents"

cmsRun nanoAOD_cfg.py >> chain.log 2>&1

echo "========= CHAIN COMPLETED ========="
echo "========= CHAIN COMPLETED =========" >> chain.log