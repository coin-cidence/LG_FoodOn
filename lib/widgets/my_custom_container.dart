import 'package:flutter/material.dart';
import '../foodList.dart'; // FoodListPage 임포트
import '../firestore_service.dart'; // FirestoreService 임포트

class MyCustomContainer extends StatefulWidget {
  @override
  _MyCustomContainerState createState() => _MyCustomContainerState();
}

class _MyCustomContainerState extends State<MyCustomContainer> {
  final FirestoreService _firestoreService = FirestoreService();
  String? shelfSerial;

  @override
  void initState() {
    super.initState();
    _fetchShelfSerial(); // Firestore에서 데이터 가져오기
  }

  Future<void> _fetchShelfSerial() async {
    try {
      // Firestore에서 모든 SMART_SHELF 데이터를 가져오기
      final shelves = await _firestoreService.fetchSmartShelvesData("6879ZASD123456");

      // "smart_shelf_serial" 값이 "SSS123456"과 일치하는 항목 찾기
      final matchingShelf = shelves.firstWhere(
            (shelf) => shelf['ShelfSerial'] == "SSS123456",
      );

      setState(() {
        shelfSerial = matchingShelf?['ShelfSerial']; // 매칭된 ShelfSerial 설정 또는 null
      });

      if (shelfSerial == null) {
        // 데이터가 없을 경우 사용자에게 알림
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("선반 데이터를 찾을 수 없습니다.")),
        );
      } else {
        print("가져온 ShelfSerial: $shelfSerial");
      }
    } catch (e) {
      print("Error fetching shelf data: $e");
      setState(() {
        shelfSerial = null; // 에러 발생 시 null로 설정
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("선반 데이터를 로드하는 중 오류가 발생했습니다.")),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          // 배경 그라데이션
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

          // 스마트 선반 텍스트와 뒤로가기 화살표
          Positioned(
            left: screenWidth * 0.07 - 24, // 텍스트 왼쪽으로 아이콘 위치 조정
            top: screenHeight * 0.06,
            child: GestureDetector(
              onTap: () {
                // 이전 화면으로 돌아가기
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("이전 화면으로 넘어갑니다")),
                );
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.pop(context); // 이전 화면으로 이동
                });
              },
              child: Row(
                children: [
                  Container(
                    width: screenWidth * 0.12,
                    height: screenHeight * 0.057,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: screenWidth * 0.06,
                    ),
                  ),
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

          // 스마트 선반 안내 텍스트
          Positioned(
            left: screenWidth * 0.14,
            top: screenHeight * 0.926,
            child: SizedBox(
              width: screenWidth * 0.72,
              height: screenHeight * 0.025,
              child: Text(
                '스마트 선반을 선택해 주세요.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFC4C4C4),
                  fontSize: 24,
                  fontFamily: 'LG EI Text TTF',
                  fontWeight: FontWeight.w400,
                  height: 0.06,
                ),
              ),
            ),
          ),

          // 선반 1 (Firestore 연동 데이터 사용)
          Positioned(
            left: screenWidth * 0.83,
            top: screenHeight * 0.22,
            child: GestureDetector(
              onTap: () {
                if (shelfSerial != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodListPage(
                        shelfSerial: shelfSerial!, // Firestore 데이터 사용
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("선반 데이터를 불러오는 중입니다.")),
                  );
                }
              },
              child: SizedBox(
                width: screenWidth * 0.087,
                height: screenHeight * 0.019,
                child: Text(
                  '선반 1',
                  style: TextStyle(
                    color: Color(0xFF00C0F5),
                    fontSize: 14,
                    fontFamily: 'LG EI Text TTF',
                    fontWeight: FontWeight.w400,
                    height: 0.18,
                    letterSpacing: -0.70,
                  ),
                ),
              ),
            ),
          ),


          Positioned(
            left: screenWidth * 0.83,
            top: screenHeight * 0.298,
            child: SizedBox(
              width: screenWidth * 0.094,
              height: screenHeight * 0.019,
              child: Text(
                '선반 2',
                style: TextStyle(
                  color: Color(0x599C9C9C),
                  fontSize: 14,
                  fontFamily: 'LG EI Text TTF',
                  fontWeight: FontWeight.w400,
                  height: 0.18,
                  letterSpacing: -0.70,
                ),
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.83,
            top: screenHeight * 0.37,
            child: SizedBox(
              width: screenWidth * 0.094,
              height: screenHeight * 0.019,
              child: Text(
                '선반 3',
                style: TextStyle(
                  color: Color(0x599C9C9C),
                  fontSize: 14,
                  fontFamily: 'LG EI Text TTF',
                  fontWeight: FontWeight.w400,
                  height: 0.18,
                  letterSpacing: -0.70,
                ),
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.83,
            top: screenHeight * 0.46,
            child: SizedBox(
              width: screenWidth * 0.094,
              height: screenHeight * 0.019,
              child: Text(
                '선반 4',
                style: TextStyle(
                  color: Color(0x599C9C9C),
                  fontSize: 14,
                  fontFamily: 'LG EI Text TTF',
                  fontWeight: FontWeight.w400,
                  height: 0.18,
                  letterSpacing: -0.70,
                ),
              ),
            ),
          ),
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
          Positioned(
            left: screenWidth * 0.27,
            top: screenHeight * 0.286,
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
                      height: screenHeight * 0.042,
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
          Positioned(
            left: screenWidth * 0.27,
            top: screenHeight * 0.345,
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
          Positioned(
            left: screenWidth * 0.27,
            top: screenHeight * 0.43,
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


          Positioned(
            left: screenWidth * 0.27,
            top: screenHeight * 0.181,
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
            top: screenHeight * 0.205,
            child: SizedBox(
              width: screenWidth * 0.16,
              height: screenHeight * 0.015,
              child: Text(
                '55.08%',
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