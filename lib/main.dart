import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'widgets/my_custom_container.dart';
import 'firebase_options.dart';
import 'FoodDetailPage.dart'; // FoodDetailPage.dart 파일 import
import 'deviceSelectionPage.dart'; // 1.3 메인 - 추가제품선택
import 'MessagePage.dart';

void main() async {
  // Firebase 초기화를 위해 필요한 설정
  // WidgetsFlutterBinding.ensureInitialized();
  // try {
  //   await Firebase.initializeApp();
  //   print('Firebase Initialized'); // 초기화 확인용 디버그 메시지
  // } catch (e) {
  //   print('Error initializing Firebase: $e');
  // }
  // runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();  // 비동기 함수 호출 전에 초기화 확인
  await Firebase.initializeApp(               // 비동기적으로 Firebase 초기화
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());

  // Firestore 데이터 업로드
  // FirestoreUploader uploader = FirestoreUploader();
  // await uploader.uploadDummyData();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 제거
      title: 'Food Detail Page',
      theme: ThemeData(
        primarySwatch: Colors.blue, // 기본 테마 색상
      ),
      // home: MessagePage(), // 초기 화면 설정
      // home: FoodDetailPage(), // 초기 화면 설정
      home: Scaffold(
        body: MyCustomContainer(), // my_custom_container.dart의 MyCustomContainer 호출
      ),
    );
  }
}


