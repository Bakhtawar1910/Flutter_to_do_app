import 'package:flutter/material.dart';
import 'package:todoapp/constant/colors.dart';
import 'package:todoapp/constant/textStyles.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/view/home/add_new_task_screen.dart';
import 'package:todoapp/view/home/widgets/build_detail_item.dart';

class TaskDetailScreen extends StatelessWidget {
  final ToDo todo;
  final Function(ToDo updatedTask) onUpdate;

  const TaskDetailScreen({
    Key? key,
    required this.todo,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Task Details',
          style: AppTextStyles.heading.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: AppColors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => AddNewTask(
                    onAdd: (updatedTask) async {
                      await onUpdate(updatedTask);
                    },
                    taskToEdit: todo,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 4,
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BuildDetailItem(
                  icon: Icons.title,
                  title: 'Title',
                  content: todo.todoText,
                ),
                Divider(
                  height: 30,
                  color: AppColors.grey.withOpacity(0.3),
                ),
                BuildDetailItem(
                  icon: Icons.description,
                  title: 'Description',
                  content: todo.description ?? 'No Description',
                ),
                Divider(
                  height: 30,
                  color: AppColors.grey.withOpacity(0.3),
                ),
                BuildDetailItem(
                  icon: Icons.access_time,
                  title: 'Time',
                  content: todo.time,
                ),
                Divider(
                  height: 30,
                  color: AppColors.grey.withOpacity(0.3),
                ),
                BuildDetailItem(
                  icon: Icons.check,
                  title: 'Task Status',
                  content: todo.isDone ? 'Completed' : 'Not Completed',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
