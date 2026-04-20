import 'package:flutter/material.dart';
import '../data/models/post_model.dart';
import '../data/repository/post_repository.dart';

class PostController extends ChangeNotifier {
  final PostRepository _repository = PostRepository();

  bool isLoading = false;
  String? errorMessage;
  bool isSuccess = false;

  Future<void> submitPost(String title, String content) async {
    isLoading = true;
    errorMessage = null;
    isSuccess = false;
    notifyListeners(); // Báo UI hiện vòng xoay loading

    try {
      final newPost = PostModel(title: title, content: content);
      await _repository.createNewPost(newPost);
      isSuccess = true; // Đánh dấu thành công
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners(); // Báo UI dừng vòng xoay
    }
  }
}