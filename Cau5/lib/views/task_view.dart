import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/task_controller.dart';
import '../widgets/task_item.dart';
import '../utils/app_styles.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskController>().loadTasks();
    });
  }

  // Hàm xử lý hiển thị thông báo
  void _showMessage(String text, Color color) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), backgroundColor: color, duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý Task (MVC)')),
      body: Consumer<TaskController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage != null) {
            return Center(child: Text(controller.errorMessage!, style: const TextStyle(color: Colors.red)));
          }

          if (controller.tasks.isEmpty) {
            return const Center(child: Text('Không có công việc nào.'));
          }

          return ListView.builder(
            // 1. TĂNG itemCount
            itemCount: controller.tasks.length + 1, 
            itemBuilder: (context, index) {
              
              // 2. KIỂM TRA: Nếu index chạy đến vị trí cuối cùng (bằng với số lượng task)
              if (index == controller.tasks.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: Center(
                    child: Text(
                      'MSSV: 6451071020',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }

              // 3. Nếu không phải dòng cuối cùng, thì vẫn render TaskItem như bình thường
              final task = controller.tasks[index];

              return TaskItem(
                task: task,
                confirmDismiss: (direction) async {
                  final success = await controller.removeTask(task.id);
                  if (success) {
                    _showMessage('Đã xóa task thành công!', AppStyles.primaryColor);
                    return true;
                  } else {
                    _showMessage('Lỗi: Không thể xóa task!', Colors.red);
                    return false;
                  }
                },
                onDeletePressed: () async {
                  final success = await controller.removeTask(task.id);
                  if (success) {
                    _showMessage('Đã xóa task thành công!', AppStyles.primaryColor);
                  } else {
                    _showMessage('Lỗi: Không thể xóa task!', Colors.red);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}