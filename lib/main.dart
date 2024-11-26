import 'package:flutter/material.dart';
import 'widgets/my_custom_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MyCustomContainer(), // my_custom_container.dart의 MyCustomContainer 호출
      ),
    );
  }
}
