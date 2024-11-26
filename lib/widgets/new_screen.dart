import 'package:flutter/material.dart';

class NewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("새로운 화면"),
      ),
      body: Center(
        child: Container(
          width: screenWidth * 0.8,
          height: screenHeight * 0.4,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              '이곳은 새로운 화면입니다!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
