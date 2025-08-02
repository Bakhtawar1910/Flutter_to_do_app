import 'package:flutter/material.dart';
import 'package:todoapp/view/home/home_screen.dart';
import 'package:todoapp/view/splash/splash_screen.dart';

void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do App',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
