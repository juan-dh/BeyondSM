# Usa una imagen base con Python
FROM python:3.11-slim-bullseye

# Establece el directorio de trabajo
WORKDIR /home/app

# Copia los archivos del proyecto (opcional)
COPY . /home/app

# Instala paquetes necesarios para análisis de datos
RUN pip install --no-cache-dir \
    pandas \
    numpy \
    matplotlib \
    scipy \
    seaborn \
    jupyterlab \
    scikit-learn \
    uproot

# Expone el puerto de JupyterLab
EXPOSE 8888

# Comando por defecto para lanzar JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]