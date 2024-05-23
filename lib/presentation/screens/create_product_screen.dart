import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistencia_de_datos/presentation/controllers/product_controller.dart';

class CreateProductScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stockController,
                decoration: InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the stock';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final name = _nameController.text;
                    final price = double.parse(_priceController.text);
                    final stock = int.parse(_stockController.text);
                    controller.createProduct(name, price, stock);
                    Get.back();
                  }
                },
                child: Text('Create Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
