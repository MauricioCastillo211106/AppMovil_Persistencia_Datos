import 'package:get/get.dart';
import 'package:persistencia_de_datos/domain/models/models.dart';
import 'package:persistencia_de_datos/domain/repositories/repositories.dart';

class ProductController extends GetxController {
  final ProductRepository productRepository;

  var products = <Product>[].obs;
  var isLoading = true.obs;

  ProductController({required this.productRepository});

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      print('Fetching products...');
      isLoading(true);
      final result = await productRepository.getProducts();
      print('Products fetched: $result');
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
}
