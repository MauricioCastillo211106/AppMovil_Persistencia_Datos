import 'package:persistencia_de_datos/domain/models/models.dart';
import 'package:persistencia_de_datos/domain/repositories/repositories.dart';
import 'package:persistencia_de_datos/infrastructure/datasources/api/api_client.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ApiClient apiClient;

  ProductRepositoryImpl({required this.apiClient});

  @override
  Future<List<Product>> getProducts() async {
    final productsRaw = await apiClient.fetchProducts();
    return productsRaw.map<Product>((json) => Product.fromJson(json)).toList();
  }

  @override
  Future<void> createProduct(Product product) async {
    await apiClient.createProduct(product);
  }

  @override
  Future<void> deleteProduct(int id) async {
    await apiClient.deleteProduct(id);
  }

  @override
  Future<void> updateProduct(Product product) async {
    await apiClient.updateProduct(product);
  }
}
