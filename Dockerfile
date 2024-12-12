FROM rasa/rasa:3.2.0

# Copiar archivos del proyecto
COPY . /app
WORKDIR /app

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    python3-dev \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-pip \
    python3-setuptools

# Configurar entorno virtual
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Actualizar pip y herramientas de instalación
RUN pip install --upgrade pip setuptools wheel

# Instalar Rasa y dependencias
RUN pip install rasa django

# Entrenar modelo
RUN rasa train

# Crear directorios de logs
RUN mkdir -p /app/logs

# Copiar configuración de supervisord
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Exponer puertos
EXPOSE 5005 5055

# Ejecutar supervisord
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
