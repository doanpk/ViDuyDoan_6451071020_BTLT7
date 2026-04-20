import 'package:flutter/material.dart';
import '../data/models/user_model.dart';
import '../data/repository/user_repository.dart';

class ProfileController extends ChangeNotifier {
  final UserRepository _repository = UserRepository();

  UserModel? currentUser;
  
  bool isFetching = false; // Trạng thái tải dữ liệu lần đầu
  bool isUpdating = false; // Trạng thái khi bấm nút Cập nhật
  String? errorMessage;

  // Lấy dữ liệu cũ
  Future<void> loadUserData() async {
    isFetching = true;
    errorMessage = null;
    notifyListeners();

    try {
      currentUser = await _repository.getUser();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isFetching = false;
      notifyListeners();
    }
  }

  // Gửi dữ liệu mới
  Future<bool> updateUserData(String newName, String newEmail) async {
    if (currentUser == null) return false;

    isUpdating = true;
    errorMessage = null;
    notifyListeners();

    try {
      // Tạo object mới với thông tin đã sửa
      final updatedUser = UserModel(
        id: currentUser!.id,
        name: newName,
        email: newEmail,
      );
      
      // Gửi lên server và nhận lại data mới nhất
      currentUser = await _repository.updateUser(updatedUser);
      return true; // Thành công
    } catch (e) {
      errorMessage = e.toString();
      return false; // Thất bại
    } finally {
      isUpdating = false;
      notifyListeners();
    }
  }
}