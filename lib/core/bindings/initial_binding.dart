import 'package:get/get.dart';
import 'package:persistencia_de_datos/domain/repositories/repositories.dart';
import 'package:persistencia_de_datos/infrastructure/datasources/api/api_client.dart';
import 'package:persistencia_de_datos/infrastructure/repositories/product_repository_impl.dart';
import 'package:persistencia_de_datos/presentation/controllers/product_controller.dart';
import 'package:persistencia_de_datos/services/network_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiClient());
    Get.lazyPut<ProductRepository>(() => ProductRepositoryImpl(apiClient: Get.find()));
    Get.lazyPut(() => ProductController(productRepository: Get.find()));
    Get.lazyPut(() => NetworkService());
  }
}
