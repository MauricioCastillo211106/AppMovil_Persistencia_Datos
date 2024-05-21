from app.models.product import Product
from database import db

class ProductRepository:

    @staticmethod
    def get_all():
        return Product.query.all()

    @staticmethod
    def get_by_id(product_id):
        return Product.query.get_or_404(product_id)

    @staticmethod
    def create(product_data):
        new_product = Product(**product_data)
        db.session.add(new_product)
        db.session.commit()
        return new_product

    @staticmethod
    def update(product_id, product_data):
        product = Product.query.get_or_404(product_id)
        for key, value in product_data.items():
            setattr(product, key, value)
        db.session.commit()
        return product

    @staticmethod
    def delete(product_id):
        product = Product.query.get_or_404(product_id)
        db.session.delete(product)
        db.session.commit()
        return product
