import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistencia_de_datos/presentation/controllers/product_controller.dart';
import 'package:persistencia_de_datos/presentation/screens/create_product_screen.dart';
import 'package:persistencia_de_datos/presentation/widgets/product_card.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              controller.fetchProducts();
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.to(() => CreateProductScreen());
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              final product = controller.products[index];
              return ProductCard(product: product, onDelete: () => controller.deleteProduct(product.id));
            },
          );
        }
      }),
    );
  }
}
