import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';

class PostApiService {
  Future<Map<String, dynamic>> createPost(Map<String, dynamic> postData) async {
    try {
      final response = await http.post(
        Uri.parse(AppConstants.postApiUrl),
        // RẤT QUAN TRỌNG: Báo cho Server biết ta đang gửi file định dạng JSON
        headers: {'Content-Type': 'application/json'},
        // Mã hóa Map thành chuỗi JSON
        body: jsonEncode(postData), 
      );

      // In response từ server ra console theo yêu cầu bài toán
      developer.log('Server Response Code: ${response.statusCode}', name: 'API_POST');
      developer.log('Server Response Body: ${response.body}', name: 'API_POST');

      // Status code 201 nghĩa là "Created" (Tạo thành công)
      if (response.statusCode == 201 || response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Lỗi Server: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Không thể kết nối: $e');
    }
  }
}