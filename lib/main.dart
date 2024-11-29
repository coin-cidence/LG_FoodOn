import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'thinqHomepage.dart';

void main() async {
  // Firestore 데이터 업로드
  // FirestoreUploader uploader = FirestoreUploader();
  // await uploader.uploadDummyData();
  WidgetsFlutterBinding.ensureInitialized(); // 비동기 함수 호출 전에 초기화 확인
  await Firebase.initializeApp( // 비동기적으로 Firebase 초기화
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 제거
      home: HomeScreen(),
    );
  }
}
