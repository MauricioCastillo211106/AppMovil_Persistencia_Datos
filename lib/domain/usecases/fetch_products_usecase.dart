
import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';

class FetchProductsUseCase {
  final ProductRepository repository;

  FetchProductsUseCase({required this.repository});

  Future<List<Product>> call() async {
    return await repository.getProducts();
  }
}
