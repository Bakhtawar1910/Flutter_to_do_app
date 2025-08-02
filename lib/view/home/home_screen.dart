import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:todoapp/constant/colors.dart';
import 'package:todoapp/constant/textStyles.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/view/home/task_detail_screen.dart';
import 'package:todoapp/view/home/to_do_item.dart';
import 'package:todoapp/view/home/add_new_task_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ToDo> toDoList = [];

  @override
  void initState() {
    super.initState();
    _loadToDos();
  }

  void _addNewTask(ToDo task) async {
    setState(() {
      toDoList.add(task);
    });
    await _saveToDos();
  }

  void _toggleTask(ToDo task) async {
    setState(() {
      task.isDone = !task.isDone;
    });
    await _saveToDos();
  }

  void _deleteTask(ToDo task) async {
    setState(() {
      toDoList.remove(task);
    });
    await _saveToDos();
  }

  Future<void> _loadToDos() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? toDoStrings = prefs.getStringList('todos');

    if (toDoStrings != null) {
      setState(() {
        toDoList = toDoStrings
            .map((jsonString) => ToDo.fromJson(json.decode(jsonString)))
            .toList();
      });
    }
  }

  Future<void> _saveToDos() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> toDoStrings =
        toDoList.map((todo) => json.encode(todo.toJson())).toList();
    await prefs.setStringList('todos', toDoStrings);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 4,
        title: Text(
          'All To Dos',
          style: AppTextStyles.heading.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: toDoList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox, size: 100, color: AppColors.grey),
                        const SizedBox(height: 16),
                        Text(
                          'No tasks yet!',
                          style: AppTextStyles.heading.copyWith(
                            fontSize: 20,
                            color: AppColors.secondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddNewTask(onAdd: _addNewTask),
                              ),
                            );
                          },
                          icon: Icon(Icons.add_circle_outline,
                              color: AppColors.primary),
                          label: Text(
                            'Tap to add your first task',
                            style: AppTextStyles.blueBody,
                          ),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: toDoList.map(
                        (todo) {
                          return ToDoItem(
                            todo: todo,
                            onToggle: () => _toggleTask(todo),
                            onDelete: () => _deleteTask(todo),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TaskDetailScreen(
                                  todo: todo,
                                  onUpdate: (updatedTodo) async {
                                    setState(() {
                                      final index = toDoList.indexOf(todo);
                                      if (index != -1) {
                                        toDoList[index] = updatedTodo;
                                      }
                                    });
                                    await _saveToDos();
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddNewTask(onAdd: _addNewTask),
            ),
          );
        },
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
