import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiService {
  static const String apiUrl = 'https://69dda596410caa3d47b9b68c.mockapi.io/User';
  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      // Chuyển đổi danh sách dynamic thành List<User>
      return body.map((item) => User.fromJson(item)).toList();
    } else {
      throw Exception('Không thể tải danh sách người dùng');
    }
  }
}