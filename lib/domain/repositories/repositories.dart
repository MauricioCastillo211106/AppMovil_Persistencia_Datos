import 'package:persistencia_de_datos/domain/models/models.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<void> createProduct(Product product);
  Future<void> deleteProduct(int id);
}
