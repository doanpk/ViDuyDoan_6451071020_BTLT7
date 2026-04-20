import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../models/task_model.dart';

class TaskApiService {
  // Lấy danh sách Tasks từ MockAPI
  Future<List<TaskModel>> fetchTasks() async {
    final response = await http.get(Uri.parse(AppConstants.taskApiUrl));
    
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => TaskModel.fromJson(json)).toList();
    } else {
      throw Exception('Lỗi tải dữ liệu');
    }
  }

  // Xóa Task trên MockAPI
  Future<bool> deleteTask(int id) async {
    // Gọi lệnh DELETE tới: https://...mockapi.io/tasks/1
    final response = await http.delete(Uri.parse('${AppConstants.taskApiUrl}/$id'));
    
    // MockAPI trả về 200 khi xóa thành công
    return response.statusCode == 200;
  }
}