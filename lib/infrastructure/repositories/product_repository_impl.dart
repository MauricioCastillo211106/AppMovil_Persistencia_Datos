
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
    try {
      if (networkService.isConnected.value) {
        final remoteProductsRaw = await apiClient.fetchProducts();
        final remoteProducts = remoteProductsRaw.map<Product>((json) => Product.fromJson(json)).toList();

        // Sincronizar productos remotos con la base de datos local
        await localDatabase.clearProducts(); // Limpia los productos locales antes de sincronizar
        for (var product in remoteProducts) {
          await localDatabase.insertProduct({
            'id': product.id,
            'name': product.name,
            'price': product.price,
            'stock': product.stock,
            'isSynced': 1,
          });
        }

        return remoteProducts;
      } else {
        final localProducts = await localDatabase.getProducts();
        return localProducts.map<Product>((json) => Product.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error fetching products: $e');
      final localProducts = await localDatabase.getProducts();
      return localProducts.map<Product>((json) => Product.fromJson(json)).toList();
    }
  }

  @override
  Future<void> createProduct(Product product) async {
    try {
      if (networkService.isConnected.value) {
        await apiClient.createProduct(product);
        await localDatabase.insertProduct({
          'name': product.name,
          'price': product.price,
          'stock': product.stock,
          'isSynced': 1,
        });
      } else {
        await localDatabase.insertProduct(product.toJsonWithoutId());
      }
    } catch (e) {
      print('Error creating product: $e');
      await localDatabase.insertProduct(product.toJsonWithoutId());
    }
  }

  @override
  Future<void> deleteProduct(int id) async {
    try {
      if (networkService.isConnected.value) {
        await apiClient.deleteProduct(id);
        await localDatabase.deleteProduct(id);
      } else {
        await localDatabase.deleteProduct(id);
      }
    } catch (e) {
      print('Error deleting product: $e');
      await localDatabase.deleteProduct(id);
    }
  }

  @override
  Future<void> updateProduct(Product product) async {
    try {
      if (networkService.isConnected.value) {
        await apiClient.updateProduct(product);
        await localDatabase.updateProduct({
          'id': product.id,
          'name': product.name,
          'price': product.price,
          'stock': product.stock,
          'isSynced': 1,
        });
      } else {
        await localDatabase.updateProduct(product.toJson());
      }
    } catch (e) {
      print('Error updating product: $e');
      await localDatabase.updateProduct(product.toJson());
    }
  }
}
