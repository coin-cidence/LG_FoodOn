import 'package:flutter/material.dart';
import 'FoodDetailPage.dart'; // FoodDetailPage.dart 파일 import
import 'MessagePage.dart';
import 'thinqHomepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      // home: MessagePage(), // 초기 화면 설정
      // home: FoodDetailPage(), // 초기 화면 설정
    );
  }
}
