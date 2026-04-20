import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../models/product_model.dart';

class SearchApiService {
  Future<List<ProductModel>> searchProducts(String keyword) async {
    // Nếu keyword rỗng, URL sẽ là: .../search?q=
    // Nếu keyword là "phone", URL sẽ là: .../search?q=phone
    final url = Uri.parse('${AppConstants.searchApiUrl}?q=$keyword');
    
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // DummyJSON trả về dữ liệu bọc trong một mảng tên là 'products'
      final List productsJson = data['products']; 
      
      return productsJson.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Lỗi kết nối máy chủ');
    }
  }
}