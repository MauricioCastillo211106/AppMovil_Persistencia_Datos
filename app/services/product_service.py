from app.repositories.product_repository import ProductRepository

class ProductService:

    @staticmethod
    def get_all_products():
        return ProductRepository.get_all()

    @staticmethod
    def get_product_by_id(product_id):
        return ProductRepository.get_by_id(product_id)

    @staticmethod
    def create_product(product_data):
        return ProductRepository.create(product_data)

    @staticmethod
    def update_product(product_id, product_data):
        return ProductRepository.update(product_id, product_data)

    @staticmethod
    def delete_product(product_id):
        return ProductRepository.delete(product_id)
