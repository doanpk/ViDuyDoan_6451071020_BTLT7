import 'dart:async';
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/search_api_service.dart';

class ProductSearchController extends ChangeNotifier {
  final SearchApiService _apiService = SearchApiService();

  List<ProductModel> products = [];
  bool isLoading = false;
  String? errorMessage;
  
  // Biến Timer dùng để đếm giờ trì hoãn gõ (Debounce)
  Timer? _debounce;

  // Lần đầu mở app, tải danh sách mặc định (keyword rỗng)
  ProductSearchController() {
    executeSearch(''); 
  }

  // Hàm gọi API thực sự
  Future<void> executeSearch(String keyword) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      products = await _apiService.searchProducts(keyword);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Hàm này gắn vào ô TextField (Người dùng cứ gõ là gọi hàm này)
  void onSearchChanged(String keyword) {
    // Nếu người dùng đang gõ mà chưa nghỉ quá 500ms -> Hủy cái đếm giờ cũ
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    
    // Đặt lại đếm giờ 500 mili giây (nửa giây). Nếu nửa giây sau không gõ gì nữa thì mới gọi API!
    _debounce = Timer(const Duration(milliseconds: 500), () {
      executeSearch(keyword.trim());
    });
  }

  @override
  void dispose() {
    _debounce?.cancel(); // Dọn rác khi tắt app
    super.dispose();
  }
}