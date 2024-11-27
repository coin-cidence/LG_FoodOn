import 'package:flutter/material.dart';
import 'new_screen.dart';  // 새 화면을 임포트
import '../foodList.dart';  // 새 화면을 임포트
import '../dummy_data.dart';
import 'package:flutter_gradient_animation_text/flutter_gradient_animation_text.dart';


class MyCustomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // 더미 데이터 로드
    final shelvesData = DummyData.getSmartShelvesData();

    // 선반 버튼을 생성하는 함수 (클릭 기능을 없앰)
    Widget createShelfButton(double left, double top, String label, int index) {
      return Positioned(
        left: left,
        top: top,
        child: SizedBox(
          width: screenWidth * 0.094,
          height: screenHeight * 0.019,
          child: Text(
            label,
            style: TextStyle(
              color: index == 0 ? Color(0xFF5ADBFF) : Color(0xFF9C9C9C), // 선반 1은 색상 변경
              fontSize: 14,
              fontFamily: 'LG EI Text TTF',
              fontWeight: index == 0 ? FontWeight.bold : FontWeight.w400, // 선반 1은 bold 처리
              height: 0.18,
              letterSpacing: -0.70,
            ),
          ),
        ),
      );
    }


    return Container(
      width: screenWidth,
      height: screenHeight,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: screenWidth,
              height: screenHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.09, -1.00),
                  end: Alignment(-0.09, 1),
                  colors: [Color(0xFFECECEC), Colors.white, Color(0xFFE9E9E9)],
                ),
              ),
            ),
          ),
          // 스마트 선반 텍스트, 그리고 화살표 부분
          Positioned(
            left: screenWidth * 0.11 - 24, // 텍스트 왼쪽으로 아이콘 위치 조정
            top: screenHeight * 0.039,
            child: GestureDetector(
              onTap: () {
                // 메시지 출력
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("홈 화면으로 넘어갑니다.")),
                );
                // 화면 전환
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewScreen()), // 새로운 화면으로 전환
                  );
                });
              },
              child: Row(
                children: [
                  // 화살표 아이콘
                  Container(
                    width: screenWidth * 0.09, // 아이콘 너비
                    height: screenHeight * 0.025, // 아이콘 높이
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black, // 아이콘 색상
                      size: screenWidth * 0.06, // 아이콘 크기
                    ),
                  ),

                  // "스마트 선반" 텍스트
                  SizedBox(
                    width: screenWidth * 0.25,
                    height: screenHeight * 0.005,
                    child: Text(
                      '스마트 선반',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'LG EI Text TTF',
                        fontWeight: FontWeight.w700,
                        height: 0.09,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),


          Positioned(
            left: screenWidth * 0.14,
            top: screenHeight * 0.91,
            child: SizedBox(
              width: screenWidth * 0.72,
              height: screenHeight * 0.045,
              child: GradientAnimationText(
                text: Text(
                  '스마트 선반을 선택해 주세요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'LG EI Text TTF',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                colors: [
                  Colors.grey, // violet
                  Colors.black54,
                  Colors.black12,
                  Colors.black26,
                ],
                duration: Duration(seconds: 3),
              ),
            ),
          ),

          // Positioned(
          //   left: screenWidth * 0.14,
          //   top: screenHeight * 0.926,
          //   child: SizedBox(
          //     width: screenWidth * 0.72,
          //     height: screenHeight * 0.025,
          //     child: Text(
          //       '스마트 선반을 선택해 주세요.',
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //         color: Color(0xFFC4C4C4),
          //         fontSize: 24,
          //         fontFamily: 'LG EI Text TTF',
          //         fontWeight: FontWeight.w400,
          //         height: 0.06,
          //       ),
          //     ),
          //   ),
          // ),


          // 선반 1 ~ 선반 4 버튼 표시
          createShelfButton(screenWidth * 0.83, screenHeight * 0.22, '선반 1',0),
          createShelfButton(screenWidth * 0.83, screenHeight * 0.298, '선반 2',1),
          createShelfButton(screenWidth * 0.83, screenHeight * 0.37, '선반 3',2),
          createShelfButton(screenWidth * 0.83, screenHeight * 0.46, '선반 4',3),


          Positioned(
            left: screenWidth * 0.18,
            top: screenHeight * 0.14,
            child: Container(
              width: screenWidth * 0.63,
              height: screenHeight * 0.73,
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.08, -1.00),
                  end: Alignment(-0.08, 1),
                  colors: [Colors.white, Color(0x59FDFDFD)],
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.23,
            top: screenHeight * 0.59,
            child: Container(
              width: screenWidth * 0.54,
              height: screenHeight * 0.26,
              decoration: ShapeDecoration(
                color: Color(0xFFD9D9D9),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.23,
            top: screenHeight * 0.163,
            child: Container(
              width: screenWidth * 0.54,
              height: screenHeight * 0.41,
              decoration: ShapeDecoration(
                color: Color(0xFFD9D9D9),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),

          /////////////////////

          // 새로운 AlertDialong 식 -> 닫기, 확인 선택지 부여함
          Positioned(
            left: screenWidth * 0.27,
            top: screenHeight * 0.286,
            child: GestureDetector(
              onTap: () {
                // 무조건 AlertDialog 표시
                showDialog(
                  context: context,
                  barrierDismissible: true, // 다이얼로그 외부 클릭 시 다이얼로그 닫기 가능
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),  // 모서리를 둥글게 만드는 부분
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 30.0),  // 이모티콘을 아래로 내리기
                        child: Center(  // 중앙 정렬을 위한 Center 위젯 사용
                          child: Image.asset(
                            'images/thinking.png',  // thinking.png 이미지 로드
                            height: 50,  // 이미지 크기 조정
                          ),
                        ),
                      ),
                      content: Container(
                        width: 180,  // AlertDialog 크기 설정 (너비)
                        height: 50,  // AlertDialog 크기 설정 (높이)
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25.0),  // 텍스트를 아래로 내리기
                          child: Center(
                            child: Text(
                              '등록된 식품이 없습니다!',
                              textAlign: TextAlign.center,  // 텍스트 중앙 정렬
                              style: TextStyle(
                                fontFamily: 'LG EI Text',  // 폰트 설정
                                fontSize: 18,
                                fontWeight: FontWeight.bold,  // 텍스트 굵게 설정
                              ),
                            ),
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),  // 버튼 간격을 아래로 조정
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();  // AlertDialog 닫기
                            },
                            child: Text('닫기'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),  // 버튼 간격을 아래로 조정
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();  // AlertDialog 닫기
                              // 화면 전환
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FoodListPage(
                                    shelfSerial: shelvesData[1]['smartShelfSerial'],
                                  ),
                                ),
                              );
                            },
                            child: Text('확인'),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                width: screenWidth * 0.46,
                height: screenHeight * 0.045,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: screenWidth * 0.46,
                        height: screenHeight * 0.045,
                        decoration: ShapeDecoration(
                          color: Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Color(0xFF9C9C9C)),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0.19,
                      top: screenHeight * 0.036,
                      child: Container(
                        width: screenWidth * 0.46,
                        height: screenHeight * 0.008,
                        decoration: ShapeDecoration(
                          color: Color(0xFF9C9C9C),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),


          Positioned(
            left: screenWidth * 0.27,
            top: screenHeight * 0.345,
            child: GestureDetector(
              onTap: () {
                // 선반 3 클릭 시 다른 화면으로 전환 및 AlertDialog 표시
                showDialog(
                  context: context,
                  barrierDismissible: true, // 다이얼로그 외부 클릭 시 다이얼로그 닫기 가능
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),  // 모서리를 둥글게 만드는 부분
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 30.0),  // 이모티콘을 아래로 내리기
                        child: Center(  // 중앙 정렬을 위한 Center 위젯 사용
                          child: Image.asset(
                            'images/thinking.png',  // thinking.png 이미지 로드
                            height: 50,  // 이미지 크기 조정
                          ),
                        ),
                      ),
                      content: Container(
                        width: 180,  // AlertDialog 크기 설정 (너비)
                        height: 70,  // AlertDialog 크기 설정 (높이)
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0),  // 텍스트를 아래로 내리기
                          child: Center(
                            child: Text(
                              '등록된 식품이 없습니다!',
                              textAlign: TextAlign.center,  // 텍스트 중앙 정렬
                              style: TextStyle(
                                fontFamily: 'LG EI Text',  // 폰트 설정
                                fontSize: 18,
                                fontWeight: FontWeight.bold,  // 텍스트 굵게 설정
                              ),
                            ),
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),  // 버튼 간격을 아래로 조정
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();  // AlertDialog 닫기
                            },
                            child: Text('닫기'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),  // 버튼 간격을 아래로 조정
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();  // AlertDialog 닫기
                              // 화면 전환 (선반 3 데이터 전달)
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FoodListPage(
                                    shelfSerial: shelvesData[2]['smartShelfSerial'],
                                  ),
                                ),
                              );
                            },
                            child: Text('확인'),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                width: screenWidth * 0.46,
                height: screenHeight * 0.079,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: screenWidth * 0.46,
                        height: screenHeight * 0.072,
                        decoration: ShapeDecoration(
                          color: Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Color(0xFF9C9C9C)),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0.19,
                      top: screenHeight * 0.064,
                      child: Container(
                        width: screenWidth * 0.46,
                        height: screenHeight * 0.008,
                        decoration: ShapeDecoration(
                          color: Color(0xFF9C9C9C),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),


          Positioned(
            left: screenWidth * 0.27,
            top: screenHeight * 0.43,
            child: GestureDetector(
              onTap: () {
                // 선반 4 클릭 시 AlertDialog 표시
                showDialog(
                  context: context,
                  barrierDismissible: true, // 다이얼로그 외부 클릭 시 다이얼로그 닫기 가능
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),  // 모서리를 둥글게 만드는 부분
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 30.0),  // 이모티콘을 아래로 내리기
                        child: Center(  // 중앙 정렬을 위한 Center 위젯 사용
                          child: Image.asset(
                            'images/thinking.png',  // thinking.png 이미지 로드
                            height: 50,  // 이미지 크기 조정
                          ),
                        ),
                      ),
                      content: Container(
                        width: 180,  // AlertDialog 크기 설정 (너비)
                        height: 70,  // AlertDialog 크기 설정 (높이)
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0),  // 텍스트를 아래로 내리기
                          child: Center(
                            child: Text(
                              '등록된 식품이 없습니다!',
                              textAlign: TextAlign.center,  // 텍스트 중앙 정렬
                              style: TextStyle(
                                fontFamily: 'LG EI Text',  // 폰트 설정
                                fontSize: 18,
                                fontWeight: FontWeight.bold,  // 텍스트 굵게 설정
                              ),
                            ),
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),  // 버튼 간격을 아래로 조정
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();  // AlertDialog 닫기
                            },
                            child: Text('닫기'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),  // 버튼 간격을 아래로 조정
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();  // AlertDialog 닫기
                              // 화면 전환 (선반 4 데이터 전달)
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FoodListPage(
                                    shelfSerial: shelvesData[3]['smartShelfSerial'],
                                  ),
                                ),
                              );
                            },
                            child: Text('확인'),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                width: screenWidth * 0.46,
                height: screenHeight * 0.074,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: screenWidth * 0.46,
                        height: screenHeight * 0.071,
                        decoration: ShapeDecoration(
                          color: Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Color(0xFF9C9C9C)),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0.19,
                      top: screenHeight * 0.064,
                      child: Container(
                        width: screenWidth * 0.46,
                        height: screenHeight * 0.008,
                        decoration: ShapeDecoration(
                          color: Color(0xFF9C9C9C),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),


          Positioned(
            left: screenWidth * 0.27,
            top: screenHeight * 0.181,
            child: GestureDetector(
              onTap: () {
                // 선반 1 클릭 시 다른 화면으로 전환
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodListPage(
                      shelfSerial: shelvesData[0]['smartShelfSerial'], // 선반 1 데이터 전달
                    ),
                  ),
                );
              },
              child: Container(
                width: screenWidth * 0.46,
                height: screenHeight * 0.096,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: screenWidth * 0.46,
                        height: screenHeight * 0.1,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Color(0xFF5ADBFF)),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0.19,
                      top: screenHeight * 0.088,
                      child: Container(
                        width: screenWidth * 0.46,
                        height: screenHeight * 0.008,
                        decoration: ShapeDecoration(
                          color: Color(0xFF5ADBFF),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),


          Positioned(
            left: screenWidth * 0.30,
            top: screenHeight * 0.239,
            child: Container(
              width: screenWidth * 0.40,
              height: screenHeight * 0.104,
            ),
          ),
          Positioned(
            left: screenWidth * 0.55,
            top: screenHeight * 0.195,
            child: SizedBox(
              width: screenWidth * 0.16,
              height: screenHeight * 0.015,
              child: Text(
                '00.00%',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFFD6D6D6),
                  fontSize: 11,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0.29,
                ),
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.63,
            top: screenHeight * 0.547,
            child: SizedBox(
              width: screenWidth * 0.12,
              height: screenHeight * 0.022,
              child: Text(
                '냉장실',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.30),
                  fontSize: 16,
                  fontFamily: 'LG EI Text TTF',
                  fontWeight: FontWeight.w400,
                  height: 0.14,
                  letterSpacing: -0.80,
                ),
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.65,
            top: screenHeight * 0.117,
            child: SizedBox(
              width: screenWidth * 0.14,
              height: screenHeight * 0.022,
              child: Text(
                '냉장고 1',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.30),
                  fontSize: 16,
                  fontFamily: 'LG EI Text TTF',
                  fontWeight: FontWeight.w400,
                  height: 0.14,
                  letterSpacing: -0.80,
                ),
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.63,
            top: screenHeight * 0.609,
            child: SizedBox(
              width: screenWidth * 0.12,
              height: screenHeight * 0.022,
              child: Text(
                '냉동실',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.30),
                  fontSize: 16,
                  fontFamily: 'LG EI Text TTF',
                  fontWeight: FontWeight.w400,
                  height: 0.14,
                  letterSpacing: -0.80,
                ),
              ),
            ),
          ),


          Positioned(
            left: 0,
            top: screenHeight * 0.974,
            child: Container(width: screenWidth, height: screenHeight * 0.026),
          ),
        ],
      ),
    );
  }
}