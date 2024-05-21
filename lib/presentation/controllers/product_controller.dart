import 'package:get/get.dart';
import 'package:persistencia_de_datos/data/models/product_model.dart';
import 'package:persistencia_de_datos/domain/usecases/fetch_products_usecase.dart';
import 'package:persistencia_de_datos/data/repositories/product_repository.dart';

class ProductController extends GetxController {
  final FetchProductsUseCase fetchProductsUseCase;

  var products = <Product>[].obs;
  var isLoading = true.obs;

  ProductController({required ProductRepository productRepository})
      : fetchProductsUseCase = FetchProductsUseCase(repository: productRepository);

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      final result = await fetchProductsUseCase();
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
      await fetchProductsUseCase.repository.deleteProduct(id);
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
      await fetchProductsUseCase.repository.createProduct(name, price, stock);
      fetchProducts();
    } catch (e) {
      print('Error creating product: $e');
    } finally {
      isLoading(false);
    }
  }
}