En esta carpeta esta lo necesario para crear el contenedor donde se puede hacer el analisis de los archivos ROOT creados en CMSSW.

Pasos para crear la imagen y el contenedor:

docker build -t data-analysis .

docker run --name my_data_science -p 8888:8888 -v /mnt/c/Users/harod/Projects/ProyectoAltasEnergias/:/mnt/ArchivosCompartidos data-analysis