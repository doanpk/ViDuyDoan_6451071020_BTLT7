import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/profile_controller.dart';
import '../common/styles/app_styles.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Gọi API lấy dữ liệu cũ ngay khi vào màn hình
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final controller = context.read<ProfileController>();
      await controller.loadUserData();
      
      // Sau khi lấy xong, điền dữ liệu vào các ô Text
      if (controller.currentUser != null) {
        _nameController.text = controller.currentUser!.name;
        _emailController.text = controller.currentUser!.email;
      }
    });
  }

  Future<void> _onSavePressed() async {
    if (_formKey.currentState!.validate()) {
      final controller = context.read<ProfileController>();
      
      // Chờ update API
      final success = await controller.updateUserData(
        _nameController.text.trim(),
        _emailController.text.trim(),
      );

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Cập nhật hồ sơ thành công!',
              style: TextStyle(
                fontSize: 24
              ),
            ),
            backgroundColor: Colors.green,
          ),
        );
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
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cập nhật hồ sơ')),
      body: Consumer<ProfileController>(
        builder: (context, controller, child) {
          // Trạng thái 1: Đang lấy dữ liệu
          if (controller.isFetching) {
            return const Center(child: CircularProgressIndicator());
          }

          // Trạng thái 2: Lỗi mạng không lấy được data
          if (controller.errorMessage != null && controller.currentUser == null) {
            return Center(child: Text(controller.errorMessage!, style: const TextStyle(color: Colors.red)));
          }

          // Trạng thái 3: Hiển thị Form để sửa
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.account_circle, size: 80, color: AppStyles.primaryColor),
                  const SizedBox(height: 20),
                  
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Họ và tên',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) => value!.isEmpty ? 'Không được để trống tên' : null,
                  ),
                  const SizedBox(height: 16),
                  
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'Không được để trống email';
                      if (!value.contains('@')) return 'Email không hợp lệ';
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: AppStyles.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    // Tắt nút nếu đang cập nhật
                    onPressed: controller.isUpdating ? null : _onSavePressed,
                    child: controller.isUpdating
                        ? const SizedBox(
                            height: 20, width: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : const Text('LƯU THAY ĐỔI', style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'MSSV: 6451071020',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}