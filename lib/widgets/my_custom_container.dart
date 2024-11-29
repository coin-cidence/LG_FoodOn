import 'package:flutter/material.dart';
import 'package:flutter_gradient_animation_text/flutter_gradient_animation_text.dart';
import '../foodList.dart';  // 새 화면을 임포트
import '../dummy_data.dart';
import 'package:avatar_glow/avatar_glow.dart';


class InnerShadowContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color shadowColor;
  final Color containerColor;

  InnerShadowContainer({
    required this.width,
    required this.height,
    required this.shadowColor,
    required this.containerColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: InnerShadowPainter(
        shadowColor: shadowColor,
        containerColor: containerColor,
      ),
      size: Size(width, height),
    );
  }
}

class InnerShadowPainter extends CustomPainter {
  final Color shadowColor;
  final Color containerColor;

  InnerShadowPainter({
    required this.shadowColor,
    required this.containerColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = containerColor
      ..style = PaintingStyle.fill;

    // 컨테이너 색상 그리기
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(8)),
      paint,
    );

    // 그림자 효과 추가
    final shadowPaint = Paint()
      ..color = shadowColor.withOpacity(0.4)  // 그림자 투명도 조정
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8);  // 블러 효과

    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(2, 2, size.width - 4, size.height - 4), Radius.circular(8)),
      shadowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}



class MyCustomContainer extends StatefulWidget {  // StatefulWidget으로 변경
  @override
  _MyCustomContainerState createState() => _MyCustomContainerState();
}

class _MyCustomContainerState extends State<MyCustomContainer> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 여기서 context를 사용해도 안전합니다.
  }

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
              color: index == 0 ? Color(0xFF6BD5FF) : Colors.white, // 선반 1은 색상 변경
              fontSize: 14,
              fontFamily: 'LGText',
              fontWeight: index == 0 ? FontWeight.bold : FontWeight.w400, // 선반 1은 bold 처리
              height: 0.18,
              letterSpacing: -0.70,
              decoration: TextDecoration.none,  // 밑줄 제거
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
                image: DecorationImage(
                  image: AssetImage('images/66.png'),
                  fit: BoxFit.cover, // 이미지가 컨테이너를 덮도록 설정
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

                // 화면 전환: 이전 페이지로 이동
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.pop(context); // 이전 화면으로 이동
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start, // 화살표와 텍스트를 나란히 배치
                children: [
                  // 화살표 아이콘
                  Container(
                    width: screenWidth * 0.09, // 아이콘 너비
                    height: screenHeight * 0.023, // 아이콘 높이
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white, // 아이콘 색상
                      size: screenWidth * 0.06, // 아이콘 크기
                    ),
                  ),

                  // "스마트 선반" 텍스트
                  SizedBox(
                    width: screenWidth * 0.25,
                    height: screenHeight * 0.03,
                    child: Text(
                      '스마트 선반',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'LGText',  // 정확한 폰트 이름 'LGText'
                        fontWeight: FontWeight.w700,  // Bold 스타일
                        height: 1.4,
                        decoration: TextDecoration.none,// 텍스트 줄 간격
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),


          Positioned(
            left: screenWidth * 0.14,
            top: screenHeight * 0.92,
            child: SizedBox(
              width: screenWidth * 0.72,
              height: screenHeight * 0.045,
              child: GradientAnimationText(
                text: Text(
                  '스마트 선반을 선택해 주세요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'LGText',
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                  ),
                ),
                colors: [
                  Colors.black54, // violet
                  Colors.black12,
                  Colors.black26,
                  Colors.black87,
                ],
                duration: Duration(seconds: 3),
              ),
            ),
          ),


          // 선반 1 ~ 선반 4 버튼 표시
          createShelfButton(screenWidth * 0.83, screenHeight * 0.23, '선반 1',0),
          createShelfButton(screenWidth * 0.83, screenHeight * 0.31, '선반 2',1),
          createShelfButton(screenWidth * 0.83, screenHeight * 0.38, '선반 3',2),
          createShelfButton(screenWidth * 0.83, screenHeight * 0.465, '선반 4',3),


          Positioned(
            left: screenWidth * 0.182,
            top: screenHeight * 0.135,
            child: Container(
              width: screenWidth * 0.63,
              height: screenHeight * 0.74,
              decoration: BoxDecoration(
                color: Colors.white, // 흰색 배경
                border: Border.all(
                  color: Color(0xFF838383), // 테두리 색상 (검정)
                  width: 3, // 테두리 두께
                // border: Border.all(width: 1), // 테두리
                ),
                borderRadius: BorderRadius.circular(8), // 둥근 모서리
              ),
            ),
          ),


          Positioned(
            left: screenWidth * 0.23,
            top: screenHeight * 0.59,
            child: Stack(
              children: [
                // 그림자 효과를 위한 CustomPaint
                CustomPaint(
                  painter: InnerShadowPainter(
                    shadowColor: Color(0xFFCFCFCF),  // 그림자 색상
                    containerColor: Color(0xFFCFCFCF),  // 컨테이너 배경색
                  ),
                  size: Size(screenWidth * 0.54, screenHeight * 0.26),
                ),
                // 실제 컨테이너
                Container(
                  width: screenWidth * 0.54,
                  height: screenHeight * 0.26,
                  decoration: ShapeDecoration(
                    color: Color(0xFFCFCFCF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),



          Positioned(
            left: screenWidth * 0.23,
            top: screenHeight * 0.163,
            child: Container(
              width: screenWidth * 0.54,
              height: screenHeight * 0.41,
              decoration: ShapeDecoration(
                color: Color(0xFFCFCFCF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),

          ///////////////////////////////////////////////////////////////////////////////////////////////

          // 새로운 AlertDialog 식 -> 닫기, 확인 선택지 부여함

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
                  backgroundColor: Colors.white,  // 배경색을 하얀색으로 설정
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
                      padding: const EdgeInsets.only(top: 27.0),  // 텍스트를 아래로 내리기
                      child: Center(
                        child: Text(
                          '등록된 식품이 없습니다!',
                          textAlign: TextAlign.center,  // 텍스트 중앙 정렬
                          style: TextStyle(
                            fontFamily: 'LGText',  // 폰트 설정
                            fontSize: 18,
                            fontWeight: FontWeight.w700,  // 텍스트 굵게 설정
                            color: Colors.black,  // 텍스트 색상을 검정색으로 설정
                          ),
                        ),
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,  // 버튼 중앙 정렬
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 1.0),  // 버튼 간격을 아래로 조정
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();  // AlertDialog 닫기
                            },
                            child: Text(
                              '닫기',
                              style: TextStyle(
                                fontFamily: 'LGText',  // 폰트 지정
                                fontSize: 16,           // 폰트 크기 (필요에 맞게 수정)
                                fontWeight: FontWeight.w500,  // 폰트 굵기 (필요에 맞게 수정)
                                color: Colors.black87,  // 버튼 텍스트 색상을 검정색으로 설정
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 50),  // 버튼 간격 조정
                        Padding(
                          padding: const EdgeInsets.only(top: 1.0),  // 버튼 간격을 아래로 조정
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
                            child: Text(
                              '이동',
                              style: TextStyle(
                                fontFamily: 'LGText',  // 폰트 지정
                                fontSize: 16,           // 폰트 크기 (필요에 맞게 수정)
                                fontWeight: FontWeight.w500,  // 폰트 굵기 (필요에 맞게 수정)
                                color: Colors.grey,  // 버튼 텍스트 색상을 검정색으로 설정
                              ),
                            ),
                          ),
                        ),
                      ],
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
                      color: Color(0xFFC6C6C6),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0.19,
                  top: screenHeight * 0.037,
                  child: Container(
                    width: screenWidth * 0.46,
                    height: screenHeight * 0.008,
                    decoration: ShapeDecoration(
                      color: Colors.grey,
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
                      backgroundColor: Colors.white,  // 배경색을 하얀색으로 설정
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
                          padding: const EdgeInsets.only(top: 27.0),  // 텍스트를 아래로 내리기
                          child: Center(
                            child: Text(
                              '등록된 식품이 없습니다!',
                              textAlign: TextAlign.center,  // 텍스트 중앙 정렬
                              style: TextStyle(
                                fontFamily: 'LGText',  // 폰트 설정
                                fontSize: 18,
                                fontWeight: FontWeight.w700,  // 텍스트 굵게 설정
                                color: Colors.black,  // 텍스트 색상을 검정색으로 설정
                              ),
                            ),
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,  // 버튼 중앙 정렬
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 1.0),  // 버튼 간격을 아래로 조정
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();  // AlertDialog 닫기
                                },
                                child: Text(
                                  '닫기',
                                  style: TextStyle(
                                    fontFamily: 'LGText',  // 폰트 지정
                                    fontSize: 16,           // 폰트 크기 (필요에 맞게 수정)
                                    fontWeight: FontWeight.w500,  // 폰트 굵기 (필요에 맞게 수정)
                                    color: Colors.black87,  // 버튼 텍스트 색상을 검정색으로 설정
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 50),  // 버튼 간격 조정
                            Padding(
                              padding: const EdgeInsets.only(top: 1.0),  // 버튼 간격을 아래로 조정
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();  // AlertDialog 닫기
                                  // 화면 전환
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FoodListPage(
                                        shelfSerial: shelvesData[2]['smartShelfSerial'],
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  '이동',
                                  style: TextStyle(
                                    fontFamily: 'LGText',  // 폰트 지정
                                    fontSize: 16,           // 폰트 크기 (필요에 맞게 수정)
                                    fontWeight: FontWeight.w500,  // 폰트 굵기 (필요에 맞게 수정)
                                    color: Colors.grey,  // 버튼 텍스트 색상을 검정색으로 설정
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                          color: Color(0xFFC6C6C6),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Colors.grey),
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
                          color: Colors.grey,
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
                      backgroundColor: Colors.white,  // 배경색을 하얀색으로 설정
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
                          padding: const EdgeInsets.only(top: 27.0),  // 텍스트를 아래로 내리기
                          child: Center(
                            child: Text(
                              '등록된 식품이 없습니다!',
                              textAlign: TextAlign.center,  // 텍스트 중앙 정렬
                              style: TextStyle(
                                fontFamily: 'LGText',  // 폰트 설정
                                fontSize: 18,
                                fontWeight: FontWeight.w700,  // 텍스트 굵게 설정
                                color: Colors.black,  // 텍스트 색상을 검정색으로 설정
                              ),
                            ),
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,  // 버튼 중앙 정렬
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 1.0),  // 버튼 간격을 아래로 조정
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();  // AlertDialog 닫기
                                },
                                child: Text(
                                  '닫기',
                                  style: TextStyle(
                                    fontFamily: 'LGText',  // 폰트 지정
                                    fontSize: 16,           // 폰트 크기 (필요에 맞게 수정)
                                    fontWeight: FontWeight.w500,  // 폰트 굵기 (필요에 맞게 수정)
                                    color: Colors.black87,  // 버튼 텍스트 색상을 검정색으로 설정
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 50),  // 버튼 간격 조정
                            Padding(
                              padding: const EdgeInsets.only(top: 1.0),  // 버튼 간격을 아래로 조정
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();  // AlertDialog 닫기
                                  // 화면 전환
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FoodListPage(
                                        shelfSerial: shelvesData[3]['smartShelfSerial'],
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  '이동',
                                  style: TextStyle(
                                    fontFamily: 'LGText',  // 폰트 지정
                                    fontSize: 16,           // 폰트 크기 (필요에 맞게 수정)
                                    fontWeight: FontWeight.w500,  // 폰트 굵기 (필요에 맞게 수정)
                                    color: Colors.grey,  // 버튼 텍스트 색상을 검정색으로 설정
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                          color: Color(0xFFC6C6C6),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0.19,
                      top: screenHeight * 0.066,
                      child: Container(
                        width: screenWidth * 0.46,
                        height: screenHeight * 0.008,
                        decoration: ShapeDecoration(
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),


          Stack(
            children: [
              // Glow 효과를 컨테이너 뒤쪽에 배치
              Positioned(
                left: screenWidth * 0.208, // 기존 컨테이너의 위치 유지
                top: screenHeight * 0.094, // 기존 컨테이너의 위치 유지
                child: AvatarGlow(
                  startDelay: const Duration(milliseconds: 1000), // Glow 시작 딜레이
                  glowColor: Colors.blue, // Glow 색상
                  endRadius: screenWidth * 0.29, // Glow 효과 반경
                  duration: const Duration(milliseconds: 2000), // Glow 지속 시간
                  repeat: true, // 반복 여부
                  showTwoGlows: true, // 두 겹의 Glow
                  child: SizedBox(
                    width: screenWidth * 0.2, // Glow 효과의 기준 크기 (컨테이너 크기와 동일)
                    height: screenHeight * 0.006,
                  ),
                ),
              ),

              // 기존 컨테이너에 버튼 기능 추가
              Positioned(
                left: screenWidth * 0.27, // 기존 컨테이너의 위치 유지
                top: screenHeight * 0.181, // 기존 컨테이너의 위치 유지
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
                    width: screenWidth * 0.46, // 기존 컨테이너 크기
                    height: screenHeight * 0.096, // 기존 컨테이너 크기
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF1EBAFB), width: 1), // 테두리
                      borderRadius: BorderRadius.circular(2), // 테두리 반경
                      color: Colors.white, // 컨테이너 배경색
                    ),
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
                                side: BorderSide(width: 1, color: Color(0xFF1EBAFB)),
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
                              color: Color(0xFF1EBAFB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),











          // Positioned(
          //   left: screenWidth * 0.27,
          //   top: screenHeight * 0.181,
          //   child: GestureDetector(
          //     onTap: () {
          //       // 선반 1 클릭 시 다른 화면으로 전환
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => FoodListPage(
          //             shelfSerial: shelvesData[0]['smartShelfSerial'], // 선반 1 데이터 전달
          //           ),
          //         ),
          //       );
          //     },
          //     child: Container(
          //       width: screenWidth * 0.46,
          //       height: screenHeight * 0.096,
          //       child: Stack(
          //         children: [
          //           Positioned(
          //             left: 0,
          //             top: 0,
          //             child: Container(
          //               width: screenWidth * 0.46,
          //               height: screenHeight * 0.1,
          //               decoration: ShapeDecoration(
          //                 color: Colors.white,
          //                 shape: RoundedRectangleBorder(
          //                   side: BorderSide(width: 1, color: Color(0xFF1EBAFB)),
          //                   borderRadius: BorderRadius.circular(2),
          //                 ),
          //               ),
          //             ),
          //           ),
          //           Positioned(
          //             left: 0.19,
          //             top: screenHeight * 0.088,
          //             child: Container(
          //               width: screenWidth * 0.46,
          //               height: screenHeight * 0.008,
          //               decoration: ShapeDecoration(
          //                 color: Color(0xFF1EBAFB),
          //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),


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
                  fontFamily: 'LGText', // 폰트 이름 확인
                  fontWeight: FontWeight.w400,
                  height: 0.29,
                  decoration: TextDecoration.none,  // 밑줄 제거
                ),
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.62,
            top: screenHeight * 0.553,
            child: SizedBox(
              width: screenWidth * 0.12,
              height: screenHeight * 0.02,
              child: Text(
                '냉장실',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.30),
                  fontSize: 16,
                  fontFamily: 'LGText', // 폰트 이름 확인
                  fontWeight: FontWeight.w400,
                  height: 0.14,
                  letterSpacing: -0.80,
                  decoration: TextDecoration.none,  // 밑줄 제거
                ),
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.63,
            top: screenHeight * 0.117,
            child: SizedBox(
              width: screenWidth * 0.14,
              height: screenHeight * 0.022,
              child: Text(
                '냉장고 1',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.30),
                  fontSize: 16,
                  fontFamily: 'LGText', // 폰트 이름 확인
                  fontWeight: FontWeight.w400,
                  height: 0.14,
                  letterSpacing: -0.80,
                  decoration: TextDecoration.none,  // 밑줄 제거
                ),
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.62,
            top: screenHeight * 0.615,
            child: SizedBox(
              width: screenWidth * 0.12,
              height: screenHeight * 0.022,
              child: Text(
                '냉동실',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.30),
                  fontSize: 16,
                  fontFamily: 'LGText', // 폰트 이름 확인
                  fontWeight: FontWeight.w400,
                  height: 0.14,
                  letterSpacing: -0.80,
                  decoration: TextDecoration.none,  // 밑줄 제거
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