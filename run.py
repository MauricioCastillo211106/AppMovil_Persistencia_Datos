from database import create_app, db
from app.routes import register_routes

app = create_app()

with app.app_context():
    db.create_all()

register_routes(app)

if __name__ == '__main__':
    app.run(debug=True)
