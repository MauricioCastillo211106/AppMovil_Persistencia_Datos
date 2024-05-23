import 'package:persistencia_de_datos/domain/models/models.dart';
import 'package:persistencia_de_datos/domain/repositories/repositories.dart';
import 'package:persistencia_de_datos/infrastructure/datasources/api/api_client.dart';
import 'package:persistencia_de_datos/infrastructure/datasources/local/local_database.dart';
import 'package:get/get.dart';
import 'package:persistencia_de_datos/services/network_service.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ApiClient apiClient;
  final LocalDatabase localDatabase = LocalDatabase();
  final NetworkService networkService = Get.find<NetworkService>();

  ProductRepositoryImpl({required this.apiClient});

  @override
  Future<List<Product>> getProducts() async {
    if (networkService.isConnected.value) {
      final productsRaw = await apiClient.fetchProducts();
      return productsRaw.map<Product>((json) => Product.fromJson(json)).toList();
    } else {
      final productsRaw = await localDatabase.getProducts();
      return productsRaw.map<Product>((json) => Product.fromJson(json)).toList();
    }
  }

  @override
  Future<void> createProduct(Product product) async {
    if (networkService.isConnected.value) {
      await apiClient.createProduct(product);
    } else {
      await localDatabase.insertProduct(product.toJsonWithoutId());
    }
  }

  @override
  Future<void> deleteProduct(int id) async {
    if (networkService.isConnected.value) {
      await apiClient.deleteProduct(id);
    } else {
      await localDatabase.deleteProduct(id);
    }
  }

  @override
  Future<void> updateProduct(Product product) async {
    if (networkService.isConnected.value) {
      await apiClient.updateProduct(product);
    } else {
      await localDatabase.updateProduct(product.toJson());
    }
  }
}
