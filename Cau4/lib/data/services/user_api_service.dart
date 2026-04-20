import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';

class UserApiService {
  // 1. Hàm lấy dữ liệu hiện tại (GET)
  Future<Map<String, dynamic>> fetchUser() async {
    final response = await http.get(Uri.parse(AppConstants.userApiUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Lỗi tải dữ liệu: ${response.statusCode}');
    }
  }

  // 2. Hàm cập nhật dữ liệu mới (PUT)
  Future<Map<String, dynamic>> updateUser(Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse(AppConstants.userApiUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8'}, // Bắt buộc khi PUT/POST
      body: jsonEncode(data),
    );

    // REST API chuẩn thường trả về 200 OK sau khi PUT thành công
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Lỗi cập nhật: ${response.statusCode}');
    }
  }
}