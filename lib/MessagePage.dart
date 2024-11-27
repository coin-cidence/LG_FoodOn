import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/FTIE_엘지배경_대지.png'), // 이미지 경로
            fit: BoxFit.cover, // 이미지가 화면에 맞게 확장
          ),
        ),
        child: Center(
          child: Text(
            '메시지 페이지',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
