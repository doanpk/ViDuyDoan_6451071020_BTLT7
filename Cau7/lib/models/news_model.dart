class NewsModel {
  final int id;
  final String title;
  final String body;

  NewsModel({required this.id, required this.title, required this.body});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      // Ép kiểu an toàn từ String sang int cho MockAPI
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'] ?? 'Không có tiêu đề',
      body: json['body'] ?? 'Không có nội dung',
    );
  }
}