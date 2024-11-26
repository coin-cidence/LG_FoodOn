import 'package:flutter/material.dart';
import 'dummy_data.dart';
import 'info_dialog.dart';

class FoodListPage extends StatefulWidget {
  final String shelfSerial; // 스마트 선반 시리얼 번호 전달

  FoodListPage({required this.shelfSerial});

  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  late String selectedShelfSerial; // 선택된 선반 시리얼 번호
  late String selectedShelf;       // DropdownButton에서 사용할 선택된 선반
  List<Map<String, dynamic>> foodData = []; // 조회된 식품 데이터를 저장

  bool _isInfoVisible = false; // 정보창 표시 여부
  GlobalKey infoButtonKey = GlobalKey(); // Key for info button to find position

  @override
  void initState() {
    super.initState();
    selectedShelfSerial = widget.shelfSerial;

    // DropdownButton 초기값 설정
    final shelvesData = DummyData.getSmartShelvesData();
    final shelfData = shelvesData.firstWhere(
          (shelf) => shelf['smartShelfSerial'] == selectedShelfSerial,
      orElse: () => {'shelfLocation': '선반 1'}, // 기본값
    );
    selectedShelf = shelfData['shelfLocation'];

    // 더미 데이터 조회
    fetchFoodData(selectedShelfSerial);
  }

  // 더미 데이터 조회 함수
  void fetchFoodData(String shelfSerial) async {
    final allFoodData = DummyData.getFoodManagementData();
    final List<Map<String, dynamic>> fetchedData = allFoodData
        .where((food) => food['smartShelfSerial'] == shelfSerial)
        .toList();

    setState(() {
      foodData = fetchedData;
    });

    if (fetchedData.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("데이터 없음"),
            content: Text("선택한 선반에 식품 정보가 없습니다."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("확인"),
              ),
            ],
          );
        },
      );
    }
  }

  double _calculateInfoDialogPosition() {
    final RenderBox? box = infoButtonKey.currentContext?.findRenderObject() as RenderBox?;
    if (box != null) {
      final Offset position = box.localToGlobal(Offset.zero);
      return position.dy + box.size.height; // 아이콘 바로 아래에 위치 설정
    }
    return 95; // 위치를 찾을 수 없을 경우 기본값
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final gridWidth = screenWidth * 0.8;
    final columns = 12;
    final cellSize = gridWidth / columns;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/FTIE_엘지배경_대지.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              // 앱바 영역
              SizedBox(height: MediaQuery.of(context).padding.top),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // 왼쪽 정렬: Back 버튼과 Dropdown
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                        DropdownButton<String>(
                          value: selectedShelf,
                          items: DummyData.getSmartShelvesData().map((shelf) {
                            return DropdownMenuItem<String>(
                              value: shelf['shelfLocation'],
                              child: Text(shelf['shelfLocation']),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedShelf = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    Spacer(), // 왼쪽과 오른쪽 간격 조정
                    // 오른쪽 정렬: Search와 Info 아이콘
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {},
                        ),
                        IconButton(
                          key: infoButtonKey,
                          icon: Icon(Icons.info),
                          onPressed: () {
                            final RenderBox box = infoButtonKey.currentContext!
                                .findRenderObject() as RenderBox;
                            final Offset position = box.localToGlobal(Offset.zero);
                            setState(() {
                              _isInfoVisible = !_isInfoVisible;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 그리드 영역
              Expanded(
                flex: 6, // 상단 영역: 60% 높이
                child: Center(
                  child: Container(
                    width: gridWidth,
                    child: Stack(
                      children: List.generate(12 * 17, (index) {
                        final row = index ~/ columns; // 세로 (행)
                        final column = index % columns; // 가로 (열)

                        final cellData = foodData.firstWhere(
                              (food) => food['foodLocation'].any(
                                      (location) => location['x'] == row && location['y'] == column),
                          orElse: () => <String, dynamic>{},
                        );

                        // 셀 색상 결정 로직
                        Color cellColor = Colors.white; // 기본값
                        if (cellData.isNotEmpty) {
                          final isUnused = DateTime.now().difference(
                            DateTime.parse(cellData['foodWeightUpdateTime']),
                          ).inDays >=
                              cellData['foodUnusedNotifPeriod'];
                          if (isUnused) {
                            cellColor = Color(0xFFF0D0FF); // 보라색
                          } else if (cellData['foodWeight'] != 0) {
                            cellColor = Color(0xFFB4E0FF); // 파란색
                          } else {
                            cellColor = Color(0xFFFFA68B); // 빨간색
                          }
                        }

                        return Positioned(
                          left: column * cellSize, // 열 위치
                          top: row * cellSize, // 행 위치
                          child: Container(
                            width: cellSize * 0.9, // 셀 크기 (간격 포함, 90%)
                            height: cellSize * 0.9, // 셀 크기 (간격 포함, 90%)
                            decoration: BoxDecoration(
                              color: cellColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),

              // 리스트 영역
              // 리스트 영역
              Divider(height: 1, color: Colors.grey), // 구분선
              Expanded(
                flex: 4, // 하단 영역: 40% 높이
                child: Center(
                  child: Container(
                    width: screenWidth * 0.8, // 리스트 영역의 너비: 화면의 90%로 설정
                    child: ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      itemCount: foodData.length,
                      itemBuilder: (context, index) {
                        final food = foodData[index];

                        // 색상 결정 로직
                        Color cellColor = Colors.white; // 기본값
                        final isUnused = DateTime.now().difference(
                          DateTime.parse(food['foodWeightUpdateTime']),
                        ).inDays >= food['foodUnusedNotifPeriod'];
                        if (isUnused) {
                          cellColor = Color(0xFFF0D0FF); // 보라색
                        } else if (food['foodWeight'] != 0) {
                          cellColor = Color(0xFFB4E0FF); // 파란색
                        } else {
                          cellColor = Color(0xFFFFA68B); // 빨간색
                        }

                        return Container(
                          width: double.infinity,
                          height: 55,
                          margin: const EdgeInsets.symmetric(vertical: 10), // 리스트 간 간격
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // 색상 박스
                              Container(
                                width: 30,
                                height: 30,
                                decoration: ShapeDecoration(
                                  color: cellColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                              // 식품 이름
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    food['foodName'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'LG EI Text TTF',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.8,
                                    ),
                                  ),
                                ),
                              ),
                              // 화살표 아이콘
                              Icon(
                                Icons.arrow_back_ios,
                                size: 16,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),

          if (_isInfoVisible)
            InfoDialog(
              xPosition: MediaQuery.of(context).size.width / 2,
              yPosition: _calculateInfoDialogPosition(),
            ),
        ],
      ),
    );
  }
}
