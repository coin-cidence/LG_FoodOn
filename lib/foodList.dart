import 'package:flutter/material.dart';
import 'dummy_data.dart';
import 'info_dialog.dart';
import 'FoodDetailPage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FoodListPage extends StatefulWidget {
  final String shelfSerial;

  FoodListPage({required this.shelfSerial});

  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  late String selectedShelfSerial;
  late String selectedShelf;
  List<Map<String, dynamic>> foodData = [];
  List<Map<String, int>> highlightedLocations = [];

  bool _isInfoVisible = false;
  GlobalKey infoButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    selectedShelfSerial = widget.shelfSerial;
    selectedShelf = _getShelfLocation(selectedShelfSerial);
    fetchFoodData(selectedShelfSerial);
  }

  String _getShelfLocation(String serial) {
    final shelvesData = DummyData.getSmartShelvesData();
    final shelf = shelvesData.firstWhere(
          (s) => s['smartShelfSerial'] == serial,
      orElse: () => {'shelfLocation': '선반 1'},
    );
    return shelf['shelfLocation'];
  }

  void fetchFoodData(String shelfSerial) {
    final allFoodData = DummyData.getFoodManagementData();
    final fetchedData = allFoodData.where((food) => food['smartShelfSerial'] == shelfSerial).toList();

    setState(() {
      foodData = fetchedData;
    });

    if (fetchedData.isEmpty) {
      _showNoDataDialog();
    }
  }

  void _showNoDataDialog() {
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

  Color _getCellColor(Map<String, dynamic> cellData) {
    if (cellData.isEmpty) return Colors.white;

    final isUnused = DateTime.now()
        .difference(DateTime.parse(cellData['foodWeightUpdateTime']))
        .inDays >=
        cellData['foodUnusedNotifPeriod'];

    if (isUnused) return Color(0xFFF0D0FF); // 보라색
    if (cellData['foodWeight'] != 0) return Color(0xFFB4E0FF); // 파란색
    return Color(0xFFFFA68B); // 빨간색
  }

  Color _getHighlightedColor(Color baseColor) {
    if (baseColor == Color(0xFFF0D0FF)) return Color(0xFFBA35FF); // 강조된 보라색
    if (baseColor == Color(0xFFB4E0FF)) return Color(0xFF2DA9FF); // 강조된 파란색
    if (baseColor == Color(0xFFFFA68B)) return Color(0xFFFF693C); // 강조된 빨간색
    return baseColor;
  }

  double _calculateInfoDialogPosition() {
    try {
      final RenderBox? box = infoButtonKey.currentContext?.findRenderObject() as RenderBox?;
      if (box != null) {
        final Offset position = box.localToGlobal(Offset.zero);
        return position.dy + box.size.height; // 정보 아이콘 아래에 위치
      }
    } catch (e) {
      print("Error calculating dialog position: $e");
    }
    return MediaQuery.of(context).size.height * 0.1; // 기본값
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final gridWidth = screenWidth * 0.8;
    final columns = 12;
    final cellSize = gridWidth / columns;

    return Scaffold(
      body: SafeArea(
        child: Stack(
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
                _buildAppBar(context),
                _buildGridArea(gridWidth, columns, cellSize),
                _buildListArea(screenWidth),
              ],
            ),
            if (_isInfoVisible)
              InfoDialog(
                xPosition: MediaQuery.of(context).size.width / 2,
                yPosition: _calculateInfoDialogPosition(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
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
                    highlightedLocations = [];
                  });
                },
              ),
            ],
          ),
          Spacer(),
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
                  setState(() {
                    _isInfoVisible = !_isInfoVisible;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGridArea(double gridWidth, int columns, double cellSize) {
    return Expanded(
      flex: 6,
      child: Center(
        child: Container(
          width: gridWidth,
          child: Stack(
            children: List.generate(12 * 17, (index) {
              final row = index ~/ columns;
              final column = index % columns;

              final cellData = foodData.firstWhere(
                    (food) => food['foodLocation'].any(
                      (loc) => loc['x'] == row && loc['y'] == column,
                ),
                orElse: () => <String, dynamic>{},
              );

              var cellColor = _getCellColor(cellData);
              if (highlightedLocations.any((loc) => loc['x'] == row && loc['y'] == column)) {
                cellColor = _getHighlightedColor(cellColor);
              }

              return Positioned(
                left: column * cellSize,
                top: row * cellSize,
                child: Container(
                  width: cellSize * 0.9,
                  height: cellSize * 0.9,
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
    );
  }

  Widget _buildListArea(double screenWidth) {
    return Expanded(
      flex: 4,
      child: Center(
        child: Container(
          width: screenWidth * 0.8,
          child: ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: foodData.length,
            itemBuilder: (context, index) {
              final food = foodData[index];
              final cellColor = _getCellColor(food);

              return Slidable(
                key: ValueKey(food['foodName']),
                endActionPane: ActionPane(
                  motion: StretchMotion(), // Stretch Motion
                  children: [
                    // 정보 버튼
                    CustomSlidableAction(
                      onPressed: (context) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodDetailPage(), // 상세보기 페이지
                          ),
                        );
                      },
                      backgroundColor: Colors.transparent,
                      child: Container(
                        width: 55, // 커스텀 너비
                        height: 55, // 커스텀 높이
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
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.info,
                          color: Colors.blue,
                          size: 24, // 아이콘 크기
                        ),
                      ),
                    ),
                    // 삭제 버튼
                    CustomSlidableAction(
                      onPressed: (context) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('삭제 확인', style: TextStyle(fontSize: 16)),
                              content: Text(
                                '해당 식품을 삭제하시겠습니까?',
                                style: TextStyle(fontSize: 14),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // 다이얼로그 닫기
                                  },
                                  child: Text(
                                    '취소',
                                    style: TextStyle(color: Color(0xFF23778F)),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      foodData.removeAt(index); // 항목 삭제
                                    });
                                    Navigator.of(context).pop(); // 다이얼로그 닫기
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("${food['foodName']} 삭제됨")),
                                    );
                                  },
                                  child: Text(
                                    '삭제',
                                    style: TextStyle(color: Color(0xFFD93512)),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      backgroundColor: Colors.transparent,
                      child: Container(
                        width: 55, // 커스텀 너비
                        height: 55, // 커스텀 높이
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
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 24, // 아이콘 크기
                        ),
                      ),
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    // 기존 클릭 기능 유지
                    setState(() {
                      highlightedLocations = List<Map<String, int>>.from(food['foodLocation']);
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    margin: const EdgeInsets.symmetric(vertical: 10),
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        // 텍스트
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
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
