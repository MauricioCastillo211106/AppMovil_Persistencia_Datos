import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:persistencia_de_datos/core/utils/constants.dart';

class ApiProvider {
  Future<List<dynamic>> fetchProducts() async {
    final response = await http.get(Uri.parse('${Constants.baseUrl}/products'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('${Constants.baseUrl}/products/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  }

  Future<void> createProduct(String name, double price, int stock) async {
    final response = await http.post(
      Uri.parse('${Constants.baseUrl}/products'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'price': price,
        'stock': stock,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create product');
    }
  }
}