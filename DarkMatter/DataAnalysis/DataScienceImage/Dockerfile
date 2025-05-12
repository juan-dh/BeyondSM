FROM continuumio/miniconda3

# Evita prompts
ENV DEBIAN_FRONTEND=noninteractive

# Establece el directorio de trabajo
WORKDIR /home/app

# Copia los archivos del proyecto (opcional)
COPY . /home/app

# Crear entorno Conda con uproot + xrootd
RUN conda create -n cmsenv python=3.10 \
    uproot \
    awkward \
    xrootd \
    matplotlib \
    pandas \
    numpy \
    jupyterlab \
    -c conda-forge && \
    conda clean --all -f -y

RUN conda run -n cmsenv pip install fsspec-xrootd

# Activar automáticamente el entorno al entrar
SHELL ["conda", "run", "-n", "cmsenv", "/bin/bash", "-c"]

# Crear directorio de trabajo
WORKDIR /home/app

# Abrir Jupyter en el puerto 8888
EXPOSE 8888

# Comando por defecto: iniciar Jupyter


ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "cmsenv", "jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]