import 'package:flutter/material.dart';
import '../models/news_model.dart';
import '../services/news_api_service.dart';

class NewsController extends ChangeNotifier {
  final NewsApiService _apiService = NewsApiService();

  List<NewsModel> newsList = [];
  bool isLoading = false; // Chỉ dùng cho lần đầu tiên mở app
  String? errorMessage;

  // 1. Hàm load lần đầu (Hiện vòng xoay ở giữa màn hình)
  Future<void> loadInitialNews() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      newsList = await _apiService.fetchNews();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // 2. Hàm khi kéo Refresh
  // Hàm này BẮT BUỘC phải trả về Future<void> để RefreshIndicator hoạt động chuẩn
  Future<void> refreshNews() async {
    try {
      // Giả lập mạng chậm 1 giây để bạn nhìn rõ cái hiệu ứng xoay xoay đẹp mắt
      await Future.delayed(const Duration(seconds: 1)); 
      
      // Tải lại dữ liệu mới
      newsList = await _apiService.fetchNews();
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Không thể làm mới: $e';
    } finally {
      // KHÔNG CẦN set isLoading = true hay false ở đây, 
      // vì RefreshIndicator đã tự vẽ cái vòng xoay kéo xuống rồi!
      notifyListeners();
    }
  }
}