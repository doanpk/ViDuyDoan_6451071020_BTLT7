import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/news_controller.dart';
import '../widgets/news_item.dart';
import '../utils/app_styles.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  @override
  void initState() {
    super.initState();
    // Gọi tải dữ liệu lần đầu
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NewsController>().loadInitialNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor.withOpacity(0.2), // Màu nền xám nhạt
      appBar: AppBar(
        title: const Text('Tin tức 24h - 6451071020'),
        elevation: 0,
      ),
      body: Consumer<NewsController>(
        builder: (context, controller, child) {
          // Xử lý khi tải lần đầu
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage != null && controller.newsList.isEmpty) {
            return Center(child: Text(controller.errorMessage!, style: const TextStyle(color: Colors.red)));
          }

          // CỐT LÕI BÀI TOÁN: Bọc ListView trong RefreshIndicator
          return RefreshIndicator(
            color: AppStyles.primaryColor,
            // Gọi hàm refreshNews. Lưu ý: Không có dấu ngoặc tròn () ở cuối
            onRefresh: controller.refreshNews, 
            child: ListView.builder(
              // Luôn luôn scroll được, ngay cả khi danh sách ít (quan trọng để kéo xuống)
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: controller.newsList.length,
              itemBuilder: (context, index) {
                return NewsItem(news: controller.newsList[index]);
              },
            ),
          );
        },
      ),
    );
  }
}