from flask import Blueprint, request, jsonify
from app.services.product_service import ProductService

product_bp = Blueprint('product_bp', __name__)

@product_bp.route('/products', methods=['GET'])
def get_products():
    products = ProductService.get_all_products()
    return jsonify([{'id': p.id, 'name': p.name, 'price': p.price, 'stock': p.stock} for p in products])

@product_bp.route('/products/<int:id>', methods=['GET'])
def get_product(id):
    product = ProductService.get_product_by_id(id)
    return jsonify({'id': product.id, 'name': product.name, 'price': product.price, 'stock': product.stock})

@product_bp.route('/products', methods=['POST'])
def add_product():
    data = request.get_json()
    new_product = ProductService.create_product(data)
    return jsonify({'message': 'Product created!', 'product': {'id': new_product.id, 'name': new_product.name, 'price': new_product.price, 'stock': new_product.stock}}), 201

@product_bp.route('/products/<int:id>', methods=['PUT'])
def update_product(id):
    data = request.get_json()
    updated_product = ProductService.update_product(id, data)
    return jsonify({'message': 'Product updated!', 'product': {'id': updated_product.id, 'name': updated_product.name, 'price': updated_product.price, 'stock': updated_product.stock}})

@product_bp.route('/products/<int:id>', methods=['DELETE'])
def delete_product(id):
    ProductService.delete_product(id)
    return jsonify({'message': 'Product deleted!'})
