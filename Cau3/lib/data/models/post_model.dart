class PostModel {
  final String? id; // ID có thể null khi ta mới tạo, server sẽ tự sinh ra
  final String title;
  final String content;

  PostModel({this.id, required this.title, required this.content});

  // Dùng khi GET API (nhận về)
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      content: json['content'] ?? '',
    );
  }

  // Dùng khi POST API (gửi đi)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }
}