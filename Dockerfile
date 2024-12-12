FROM rasa/rasa:3.2.0

# Copiar archivos al contenedor
COPY . /app
WORKDIR /app

# Instalar dependencias mínimas
RUN apt-get update --fix-missing && apt-get install -y libssl-dev libffi-dev

# Crear entorno virtual (opcional)
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Actualizar pip
RUN pip install --upgrade pip setuptools wheel

# Instalar dependencias adicionales
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
