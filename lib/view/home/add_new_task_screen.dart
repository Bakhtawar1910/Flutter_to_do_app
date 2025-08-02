import 'package:flutter/material.dart';
import 'package:todoapp/constant/colors.dart';
import 'package:todoapp/constant/textStyles.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/view/home/widgets/custom_button.dart';

import 'package:todoapp/view/home/widgets/custom_input_field.dart';
import 'package:intl/intl.dart';

class AddNewTask extends StatefulWidget {
  final Function(ToDo) onAdd;
  final ToDo? taskToEdit;

  const AddNewTask({
    super.key,
    required this.onAdd,
    this.taskToEdit,
  });

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.taskToEdit != null) {
      final parts = widget.taskToEdit!.time.split('|');
      _titleController.text = widget.taskToEdit!.todoText;
      _descController.text = widget.taskToEdit!.description ?? '';
      _dateController.text = parts.length > 0 ? parts[0].trim() : '';
      _timeController.text = parts.length > 1 ? parts[1].trim() : '';
    }
  }

  void _submitTask() async {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();
    final date = _dateController.text.trim();
    final time = _timeController.text.trim();

    if (title.isEmpty || date.isEmpty || time.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill title, date, and time')),
      );
      return;
    }

    final updatedTask = ToDo(
      todoText: title,
      description: desc,
      isDone: widget.taskToEdit?.isDone ?? false,
      time: '$date | $time',
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    await widget.onAdd(updatedTask);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      _dateController.text = DateFormat('dd MM yyyy').format(picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final now = DateTime.now();
      final dt =
          DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
      _timeController.text = DateFormat('hh:mm a').format(dt);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.taskToEdit != null;

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
          isEditing ? 'Edit Task' : 'New Task',
          style: AppTextStyles.heading.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: Column(
            children: [
              CustomInputField(
                hintText: 'Enter title',
                controller: _titleController,
              ),
              const SizedBox(height: 15),
              CustomInputField(
                hintText: 'Add a description',
                isMultiLine: true,
                controller: _descController,
              ),
              const SizedBox(height: 15),
              CustomInputField(
                hintText: 'Select date',
                readOnly: true,
                suffixIcon: Icons.calendar_today,
                controller: _dateController,
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 15),
              CustomInputField(
                hintText: 'Select Time',
                readOnly: true,
                suffixIcon: Icons.access_time,
                controller: _timeController,
                onTap: () => _selectTime(context),
              ),
              const SizedBox(height: 40),
              CustomButton(
                label: isEditing ? 'Update Task' : 'Add Task',
                onPressed: _submitTask,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
