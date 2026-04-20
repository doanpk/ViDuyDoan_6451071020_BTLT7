import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../utils/app_styles.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  final Future<bool> Function(DismissDirection) confirmDismiss;
  final VoidCallback onDeletePressed;

  const TaskItem({
    super.key,
    required this.task,
    required this.confirmDismiss,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(task.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        color: AppStyles.deleteColor,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: confirmDismiss,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          leading: Icon(
            task.completed ? Icons.check_circle : Icons.radio_button_unchecked,
            color: task.completed ? AppStyles.primaryColor : Colors.grey,
          ),
          title: Text(task.title),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline, color: AppStyles.deleteColor),
            onPressed: onDeletePressed,
          ),
        ),
      ),
    );
  }
}