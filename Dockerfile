# Usa la imagen base de Rasa
FROM rasa/rasa:3.2.0 
# Reemplaza con la versión correspondiente

# Copia los archivos del proyecto al contenedor
COPY . /app

# Define el directorio de trabajo
WORKDIR /app

# Instala dependencias adicionales si es necesario
RUN python --version

RUN pip install rasa 
RUN pip install django

# Entrena el modelo al construir la imagen
RUN rasa train

# Expone los puertos para la API y las acciones
EXPOSE 5005 5055

# Usa supervisord para manejar múltiples procesos
RUN apt-get update && apt-get install -y supervisor

# Copia la configuración de supervisord
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Comando para iniciar supervisord
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]