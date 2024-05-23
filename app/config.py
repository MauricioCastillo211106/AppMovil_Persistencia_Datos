import os
from dotenv import load_dotenv

class Config:
    load_dotenv()  # Correcto para cargar el archivo .env

    # Asegúrate de usar la variable como un atributo de clase
    SQLALCHEMY_DATABASE_URI = os.getenv("DATABASE_URL")
    SQLALCHEMY_TRACK_MODIFICATIONS = False
