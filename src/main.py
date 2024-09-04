from fastapi import FastAPI
import logging
from datetime import datetime

# Configuration des logs
log_filename = datetime.now().strftime("app_logs_%Y%m%d_%H%M%S.log")
logging.basicConfig(filename=log_filename, level=logging.INFO, 
                    format='%(asctime)s - %(levelname)s - %(message)s')

app = FastAPI()

@app.get("/")
def read_root():
    logging.info("Accès à la route principale")
    return {"message": "Salut utilisateur"}
