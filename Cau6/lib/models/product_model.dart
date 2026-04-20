class ProductModel {
  final int id;
  final String title;
  final double price;
  final String thumbnail;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Không có tên',
      price: (json['price'] ?? 0).toDouble(),
      thumbnail: json['thumbnail'] ?? '',
    );
  }
}