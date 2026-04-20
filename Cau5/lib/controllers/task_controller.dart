import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/task_api_service.dart';

class TaskController extends ChangeNotifier {
  final TaskApiService _apiService = TaskApiService();

  List<TaskModel> tasks = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadTasks() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      tasks = await _apiService.fetchTasks();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> removeTask(int id) async {
    try {
      final isDeleted = await _apiService.deleteTask(id);
      if (isDeleted) {
        tasks.removeWhere((task) => task.id == id);
        notifyListeners(); // Cập nhật lại UI
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}