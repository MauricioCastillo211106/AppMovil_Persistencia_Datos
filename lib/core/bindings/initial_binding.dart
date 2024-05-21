import 'package:get/get.dart';
import 'package:persistencia_de_datos/presentation/controllers/product_controller.dart';
import 'package:persistencia_de_datos/data/repositories/product_repository.dart';
import 'package:persistencia_de_datos/core/network/api_provider.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(() => ApiProvider());
    Get.lazyPut<ProductRepository>(() => ProductRepository(apiProvider: Get.find()));
    Get.lazyPut<ProductController>(() => ProductController(productRepository: Get.find()));
  }
}
