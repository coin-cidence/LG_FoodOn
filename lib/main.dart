import 'package:flutter/material.dart';
import 'foodList.dart'; // FoodListPage가 정의된 파일 import

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(), // 메인 화면 설정
    );
  }
}

// 메인 화면
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메인 화면'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodListPage(shelfName: '선반 1'),
                  ),
                );
              },
              child: Text('선반 1'), // 버튼 텍스트
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodListPage(shelfName: '선반 2'),
                  ),
                );
              },
              child: Text('선반 2'), // 버튼 텍스트
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodListPage(shelfName: '선반 3'),
                  ),
                );
              },
              child: Text('선반 3'), // 버튼 텍스트
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodListPage(shelfName: '선반 4'),
                  ),
                );
              },
              child: Text('선반 4'), // 버튼 텍스트
            ),
          ],
        ),
      ),
    );
  }
}
