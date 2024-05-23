class Product {
  final int id;
  final String name;
  final double price;
  final int stock;

  Product({required this.id, required this.name, required this.price, required this.stock});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      stock: json['stock'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'stock': stock,
    };
  }
}