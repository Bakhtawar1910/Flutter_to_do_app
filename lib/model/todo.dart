import 'dart:convert';

class ToDo {
  final String todoText;
  final String? description;
  bool isDone;
  final String time;

  ToDo({
    required this.todoText,
    this.description,
    this.isDone = false,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'todoText': todoText,
      'description': description,
      'isDone': isDone,
      'time': time,
    };
  }

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      todoText: json['todoText'],
      time: json['time'],
      description: json['description'],
      isDone: json['isDone'],
    );
  }

  static List<ToDo> todoList() => [];
}
