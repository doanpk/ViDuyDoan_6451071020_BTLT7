class TaskModel {
  final int id;
  final String title;
  final bool completed;

  TaskModel({required this.id, required this.title, required this.completed});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      // ÉP KIỂU AN TOÀN TỪ STRING SANG INT ĐỂ TRÁNH LỖI MOCKAPI
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'] ?? 'Không có tiêu đề',
      completed: json['completed'] ?? false,
    );
  }
}