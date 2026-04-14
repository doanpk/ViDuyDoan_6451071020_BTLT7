class User {
  final String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString() ?? 'N/A',
      name: json['name']?.toString() ?? 'Khách ẩn danh',
      email: json['email']?.toString() ?? 'Chưa cập nhật email',
    );
  }
}