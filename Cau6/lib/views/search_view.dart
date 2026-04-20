import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/search_controller.dart';
import '../widgets/product_item.dart';
import '../utils/app_styles.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: AppBar(
        title: const Text('Tìm kiếm Sản phẩm - 6451071020'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // 1. Ô Nhập liệu (TextField)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              // Gắn hàm Debounce vào sự kiện onChanged
              onChanged: (value) {
                context.read<ProductSearchController>().onSearchChanged(value);
              },
              decoration: InputDecoration(
                hintText: 'Nhập tên sản phẩm (VD: phone, laptop...)',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    context.read<ProductSearchController>().executeSearch(''); // Trả về list ban đầu
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // 2. Danh sách kết quả (ListView)
          Expanded(
            child: Consumer<ProductSearchController>(
              builder: (context, controller, child) {
                // Đang tải dữ liệu
                if (controller.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Lỗi mạng
                if (controller.errorMessage != null) {
                  return Center(child: Text(controller.errorMessage!, style: const TextStyle(color: Colors.red)));
                }

                // Không tìm thấy kết quả
                if (controller.products.isEmpty) {
                  return const Center(child: Text('Không tìm thấy sản phẩm nào! 😢', style: TextStyle(fontSize: 16)));
                }

                // Hiển thị danh sách
                return ListView.builder(
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    return ProductItem(product: controller.products[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}