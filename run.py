from flask import Flask
from flask_cors import CORS
from database import create_app, db
from app.routes import register_routes

app = create_app()
CORS(app)  # Habilitar CORS para toda la aplicación

with app.app_context():
    db.create_all()

register_routes(app)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
