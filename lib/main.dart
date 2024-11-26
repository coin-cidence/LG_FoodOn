import 'package:flutter/material.dart';
import 'dummy_data.dart';
import 'foodList.dart'; // FoodListPage가 정의된 파일 import

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 숨기기
      home: MyHomePage(), // 메인 화면 설정
    );
  }
}

// 메인 화면
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final shelvesData = DummyData.getSmartShelvesData();

    return Scaffold(
      appBar: AppBar(
        title: Text('스마트 선반 관리'), // 앱바 제목
      ),
      body: Center(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          itemCount: shelvesData.length,
          itemBuilder: (context, index) {
            final shelf = shelvesData[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodListPage(
                        shelfSerial: shelf['smartShelfSerial'],
                      ),
                    ),
                  );
                },
                child: Text(shelf['shelfLocation']), // 버튼 텍스트
              ),
            );
          },
        ),
      ),
    );
  }
}
