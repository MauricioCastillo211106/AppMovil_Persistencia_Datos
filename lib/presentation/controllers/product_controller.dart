import 'package:get/get.dart';
import 'package:persistencia_de_datos/domain/models/models.dart';
import 'package:persistencia_de_datos/domain/repositories/repositories.dart';
import 'package:persistencia_de_datos/infrastructure/datasources/local/local_database.dart';
import 'package:persistencia_de_datos/services/network_service.dart';

class ProductController extends GetxController {
  final ProductRepository productRepository;
  final LocalDatabase localDatabase = LocalDatabase();
  final NetworkService networkService = Get.find<NetworkService>();

  var products = <Product>[].obs;
  var isLoading = true.obs;

  ProductController({required this.productRepository});

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    networkService.isConnected.listen((isConnected) {
      if (isConnected) {
        syncLocalData();
      }
    });
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      final result = await productRepository.getProducts();
      products.assignAll(result);
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      isLoading(false);
    }
  }

  void deleteProduct(int id) async {
    try {
      isLoading(true);
      await productRepository.deleteProduct(id);
      fetchProducts();
    } catch (e) {
      print('Error deleting product: $e');
    } finally {
      isLoading(false);
    }
  }

  void createProduct(String name, double price, int stock) async {
    try {
      isLoading(true);
      await productRepository.createProduct(Product(id: 0, name: name, price: price, stock: stock));
      fetchProducts();
    } catch (e) {
      print('Error creating product: $e');
    } finally {
      isLoading(false);
    }
  }

  void updateProduct(int id, String name, double price, int stock) async {
    try {
      isLoading(true);
      await productRepository.updateProduct(Product(id: id, name: name, price: price, stock: stock));
      fetchProducts();
    } catch (e) {
      print('Error updating product: $e');
    } finally {
      isLoading(false);
    }
  }

  void syncLocalData() async {
    final localProducts = await localDatabase.getProducts();
    for (var product in localProducts) {
      await productRepository.createProduct(Product.fromJson(product));
      await localDatabase.deleteProduct(product['id']);
    }
    fetchProducts();
  }
}
