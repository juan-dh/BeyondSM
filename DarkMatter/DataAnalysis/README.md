# Data Analysis

`/DataAnalysis` contiene los datasets que son utiles para comparar con la señal generada en CMSSW. 

En `DataScienceImage` esta lo necesario para crear el contenedor donde se puede hacer el análisis de los archivos `.root` creados en CMSSW.Para ello es necesario para montar la imagen `data-science` en Docker.

## Datasets

Los datasets pueden ser descargados con `downloadDatasets.sh`.

### `/Background`

Link de "Analysis of Higgs boson decays to two tau leptons using data and simulation of events at the CMS detector from 2012"

https://opendata.cern.ch/record/12350

Link de "DYJetsToLL dataset in reduced NanoAOD format for education and outreach" (Mas útil)

https://opendata.cern.ch/record/12353

⚠️ Los datos están inaccesibles por tiempos de conexión, usaremos una version alterna almacenada en root.cern

https://root.cern/files/HiggsTauTauReduced/DYJetsToLL.root

Repositorio en root.cern

https://root.cern/files/HiggsTauTauReduced/

### `/CMS`

Link de "Run2012B_TauPlusX dataset in reduced NanoAOD format for education and outreach
"

https://opendata.cern.ch/record/12358

⚠️ Los datos están inaccesibles por tiempos de conexión, usaremos una version alterna almacenada en root.cern

https://root.cern/files/HiggsTauTauReduced/Run2012B_TauPlusX.root

## Imagen data-science

Pasos para crear la imagen y el contenedor, dentro de `DataScienceImage` ejecuta:

```
docker build -t data-science .

docker run --name my_data_science -p 8888:8888 -v /mnt/c/Users/harod/Projects/ProyectoAltasEnergias/:/mnt/ArchivosCompartidos data-science
```