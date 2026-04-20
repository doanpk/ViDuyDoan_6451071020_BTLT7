import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/post_controller.dart';
import '../common/styles/app_styles.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  void _onPublishPressed() async {
    // 1. Kiểm tra Validate form
    if (_formKey.currentState!.validate()) {
      // 2. Gọi Controller để gọi API
      final controller = context.read<PostController>();
      await controller.submitPost(
        _titleController.text.trim(),
        _contentController.text.trim(),
      );

      // 3. Hiển thị thông báo (SnackBar) dựa trên kết quả
      if (!mounted) return;
      
      if (controller.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Post created successfully!',
              style: TextStyle(fontSize: 25),
            ),
            backgroundColor: Colors.green,
          ),
        );
        // Xóa text sau khi đăng thành công
        _titleController.clear();
        _contentController.clear();
      } else if (controller.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(controller.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tạo bài viết mới')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Tiêu đề',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Vui lòng nhập tiêu đề' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                maxLines: 5, // Cho phép nhập nhiều dòng
                decoration: const InputDecoration(
                  labelText: 'Bạn đang nghĩ gì?',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) => value!.isEmpty ? 'Vui lòng nhập nội dung' : null,
              ),
              const SizedBox(height: 24),
              
              // Nút bấm: Đổi giao diện nếu đang loading
              Consumer<PostController>(
                builder: (context, controller, child) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: AppStyles.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: controller.isLoading ? null : _onPublishPressed,
                    child: controller.isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : const Text('ĐĂNG BÀI', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  );
                },
              ),
              const SizedBox(height: 30),
              Text(
                'MSSV: 6451071020',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}