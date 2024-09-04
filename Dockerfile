# Utiliser une image Python 3.10 slim comme base
FROM python:3.10-slim

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier les fichiers de l'application dans le conteneur
COPY . /app

# Installer les dépendances
RUN pip install --no-cache-dir --upgrade pip && \
    pip install -r requirements.txt


# Exposer le port que Uvicorn va utiliser
EXPOSE 8000

# Commande pour démarrer Uvicorn avec le fichier de configuration des logs
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000", "--log-config", "logging_config.yaml"]