import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dummy_data.dart';
import 'info_dialog.dart';
import 'FoodDetailPage.dart';

class FoodListPage extends StatefulWidget {
  final String shelfSerial;

  FoodListPage({required this.shelfSerial});

  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  late String selectedShelf;
  late String selectedShelfSerial;
  List<Map<String, dynamic>> allFoodData = []; // 전체 데이터를 저장
  List<Map<String, dynamic>> filteredFoodData = []; // 필터된 데이터를 저장
  List<Map<String, int>> highlightedLocations = [];

  bool _isInfoVisible = false;
  GlobalKey infoButtonKey = GlobalKey();

  String selectedFilter = "가나다순"; // 기본 필터값

  @override
  void initState() {
    super.initState();
    selectedShelfSerial = widget.shelfSerial;
    selectedShelf = _getShelfLocation(selectedShelfSerial);
    _fetchAllFoodData(selectedShelfSerial);
    _applyFilter(selectedFilter);
  }

  String _getShelfLocation(String serial) {
    final shelvesData = DummyData.getSmartShelvesData();
    final shelf = shelvesData.firstWhere(
          (s) => s['smartShelfSerial'] == serial,
      orElse: () => {'shelfLocation': '선반 1'},
    );
    return shelf['shelfLocation'];
  }

  // 모든 데이터를 한 번만 가져옴

  void _fetchAllFoodData(String shelfSerial) {
    final allData = DummyData.getFoodManagementData();
    final shelfData = allData.where((food) => food['smartShelfSerial'] == shelfSerial).toList();

    setState(() {
      allFoodData = shelfData;
      if (shelfData.isEmpty) {
        _showNoDataDialog();
      } else {
        filteredFoodData = List.from(allFoodData);
      }
    });
  }
  void _showNoDataDialog() {
    if (!mounted) return; // 위젯이 트리에서 제거되었을 경우 호출하지 않음
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,  // 배경색을 하얀색으로 설정
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),  // 모서리를 둥글게 만드는 부분
          ),
          title: Text("식품을 등록하세요!"),
          content: Text("식품을 등록하면 선반에 표시됩니다."),
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

  // 필터 적용 함수
  void _applyFilter(String filter) {
    List<Map<String, dynamic>> filteredData = List.from(allFoodData);

    // 필터 조건에 따라 정렬 및 필터링
    switch (filter) {
      case "가나다순":
        filteredData.sort((a, b) => a['foodName'].toString().compareTo(b['foodName'].toString()));
        break;
      case "오래된순":
        filteredData.sort((a, b) => DateTime.parse(a['foodRegisterDate']).compareTo(DateTime.parse(b['foodRegisterDate'])));
        break;
      case "장기미사용식품":
        filteredData = filteredData.where((food) {
          final daysSinceUpdate = DateTime.now().difference(DateTime.parse(food['foodWeightUpdateTime'])).inDays;
          return daysSinceUpdate >= food['foodUnusedNotifPeriod'];
        }).toList();
        break;
    }

    setState(() {
      filteredFoodData = filteredData; // 필터된 데이터를 저장
    });
  }

  Color _getCellColor(Map<String, dynamic> cellData) {
    if (cellData.isEmpty) return Colors.white;

    final isUnused = DateTime.now()
        .difference(DateTime.parse(cellData['foodWeightUpdateTime']))
        .inDays >= cellData['foodUnusedNotifPeriod'];

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

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _buildBackground(),
            Column(
              children: [
                _buildAppBar(context),
                _buildGridArea(screenWidth),
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

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/FTIE_엘지배경_대지.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
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
                filteredFoodData = List.from(allFoodData);
              });
            },
          ),
          Spacer(),
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
    );
  }

  Widget _buildGridArea(double screenWidth) {
    final gridWidth = screenWidth * 0.8;
    final columns = 12;
    final cellSize = gridWidth / columns;

    return Expanded(
      flex: 6,
      child: Center(
        child: Container(
          width: gridWidth,
          child: Stack(
            children: List.generate(12 * 17, (index) {
              final row = index ~/ columns;
              final column = index % columns;

              final cellData = allFoodData.firstWhere(
                    (food) => food['foodLocation'].any((loc) => loc['x'] == row && loc['y'] == column),
                orElse: () => <String, dynamic>{},
              );

              var cellColor = _getCellColor(cellData);
              if (highlightedLocations.any((loc) => loc['x'] == row && loc['y'] == column)) {
                cellColor = _getHighlightedColor(cellColor);
              }

              return Positioned(
                left: column * cellSize,
                top: row * cellSize,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      // 클릭된 좌표가 포함된 식품 찾기
                      final selectedFood = allFoodData.firstWhere(
                            (food) => food['foodLocation'].any(
                              (loc) => loc['x'] == row && loc['y'] == column,
                        ),
                        orElse: () => <String, dynamic>{},
                      );

                      if (selectedFood.isNotEmpty) {
                        if (highlightedLocations.isNotEmpty &&
                            highlightedLocations.every(
                                  (loc) => selectedFood['foodLocation'].contains(loc),
                            )) {
                          highlightedLocations = [];
                          filteredFoodData = List.from(allFoodData);
                        } else {
                          highlightedLocations = List<Map<String, int>>.from(selectedFood['foodLocation']);
                          filteredFoodData = allFoodData.where((food) {
                            return food['foodLocation'].any((loc) =>
                                highlightedLocations.any((highlightedLoc) =>
                                loc['x'] == highlightedLoc['x'] && loc['y'] == highlightedLoc['y']));
                          }).toList();
                        }
                      } else {
                        highlightedLocations = [];
                        filteredFoodData = List.from(allFoodData);
                      }
                    });
                  },
                  child: Container(
                    width: cellSize * 0.9,
                    height: cellSize * 0.9,
                    decoration: BoxDecoration(
                      color: cellColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFilterRow(),
              SizedBox(height: 2),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: filteredFoodData.length,
                  itemBuilder: (context, index) {
                    final food = filteredFoodData[index];
                    return _buildFoodListItem(food, index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildFilterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "식품목록",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        DropdownButton<String>(
          value: selectedFilter,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Color(0xFFAEAEAE),
            size: 18.0,
          ),
          items: ["가나다순", "오래된순", "장기미사용식품"].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFAEAEAE),
                ),
              ),
            );
          }).toList(),
          dropdownColor: Color(0xFFFFFFFF),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedFilter = newValue;
                _applyFilter(newValue);
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildFoodListItem(Map<String, dynamic> food, int index) {
    return Slidable(
      key: ValueKey(food['foodName']),
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          CustomSlidableAction(
            onPressed: (context) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodDetailPage(),
                ),
              );
            },
            backgroundColor: Colors.transparent,
            child: Container(
              width: 55,
              height: 55,
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
                size: 24,
              ),
            ),
          ),
          CustomSlidableAction(
            onPressed: (context) {
              _showDeleteDialog(index);
            },
            backgroundColor: Colors.transparent,
            child: Container(
              width: 55,
              height: 55,
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
                size: 24,
              ),
            ),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            // 현재 하이라이트 된 위치가 이미 포함되어 있는지 확인
            if (highlightedLocations.any((loc) => food['foodLocation'].contains(loc))) {
              // 포함되어 있다면 하이라이트 해제
              highlightedLocations.removeWhere((loc) => food['foodLocation'].contains(loc));
            } else {
              // 포함되어 있지 않다면 하이라이트 추가
              highlightedLocations = List<Map<String, int>>.from(food['foodLocation']);
            }
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
            Container(
              width: 30,
              height: 30,
              decoration: ShapeDecoration(
                color: _getCellColor(food),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  food['foodName'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
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
  }

// 삭제 확인 다이얼로그 표시
  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('삭제 확인'),
          content: Text('해당 식품을 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // 삭제할 식품의 위치 정보를 가져옴
                  final deletedFoodLocations = filteredFoodData[index]['foodLocation'];

                  // filteredFoodData에서 해당 항목 삭제
                  filteredFoodData.removeAt(index);

                  // allFoodData에서도 해당 항목을 삭제
                  allFoodData.removeWhere((food) => food['foodLocation'] == deletedFoodLocations);

                  // 그리드에서 삭제된 항목과 관련된 좌표 업데이트
                  highlightedLocations.removeWhere((highlightedLoc) => deletedFoodLocations.any(
                          (loc) => loc['x'] == highlightedLoc['x'] && loc['y'] == highlightedLoc['y']));
                });
                Navigator.of(context).pop();
              },
              child: Text('삭제', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
