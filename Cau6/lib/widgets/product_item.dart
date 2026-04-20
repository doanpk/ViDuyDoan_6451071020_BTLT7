import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../utils/app_styles.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            product.thumbnail,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            // Xử lý lỗi nếu ảnh không tải được
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),
          ),
        ),
        title: Text(product.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('\$${product.price}', style: const TextStyle(color: AppStyles.primaryColor, fontSize: 16)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}