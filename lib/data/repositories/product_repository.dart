
import '../../core/network/api_provider.dart';
import '../models/product_model.dart';


class ProductRepository {
  final ApiProvider apiProvider;

  ProductRepository({required this.apiProvider});

  Future<List<Product>> getProducts() async {
    final productsRaw = await apiProvider.fetchProducts();
    return productsRaw.map<Product>((json) => Product.fromJson(json)).toList();
  }

  Future<void> deleteProduct(int id) async {
    await apiProvider.deleteProduct(id);
  }

  Future<void> createProduct(String name, double price, int stock) async {
    await apiProvider.createProduct(name, price, stock);
  }
}