import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../models/news_model.dart';

class NewsApiService {
  Future<List<NewsModel>> fetchNews() async {
    final response = await http.get(Uri.parse(AppConstants.newsApiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      
      // Trộn ngẫu nhiên danh sách để mỗi lần kéo Refresh nhìn sẽ khác đi
      data.shuffle(); 
      
      return data.map((json) => NewsModel.fromJson(json)).toList();
    } else {
      throw Exception('Lỗi máy chủ: Mã ${response.statusCode}');
    }
  }
}