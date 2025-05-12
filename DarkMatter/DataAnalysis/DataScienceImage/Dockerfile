FROM continuumio/miniconda3

# Evita prompts
ENV DEBIAN_FRONTEND=noninteractive

# Crear entorno Conda con uproot + xrootd
RUN conda create -n cmsenv python=3.10 \
    uproot \
    awkward \
    xrootd \
    matplotlib \
    jupyterlab \
    -c conda-forge && \
    conda clean --all -f -y

# Activar automáticamente el entorno al entrar
SHELL ["conda", "run", "-n", "cmsenv", "/bin/bash", "-c"]

# Crear directorio de trabajo
WORKDIR /home/app

# Abrir Jupyter en el puerto 8888
EXPOSE 8888

# Comando por defecto: iniciar Jupyter
CMD ["conda", "run", "-n", "cmsenv", "jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]