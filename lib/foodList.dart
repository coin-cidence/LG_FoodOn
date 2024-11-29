import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'FoodDetailPage.dart';
import 'info_dialog.dart';

class FoodListPage extends StatefulWidget {
  final String shelfSerial;

  FoodListPage({required this.shelfSerial});

  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  late String selectedShelfSerial;
  String? shelfName;
  List<Map<String, dynamic>> foodData = [];
  List<Map<String, int>> highlightedLocations = [];
  bool _isInfoVisible = false;
  GlobalKey infoButtonKey = GlobalKey();

  String selectedFilter = "가나다순"; // 기본 필터값

  @override
  void initState() {
    super.initState();
    selectedShelfSerial = widget.shelfSerial;
    fetchShelfName(selectedShelfSerial);
    fetchFoodData(selectedShelfSerial);
  }

  // Firestore에서 선반 이름 가져오기
  Future<void> fetchShelfName(String shelfSerial) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('SMART_SHELF')
          .where('smart_shelf_serial', isEqualTo: shelfSerial)
          .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          shelfName = snapshot.docs.first['smart_shelf_name'];
        });
      } else {
        setState(() {
          shelfName = "이름 없음";
        });
      }
    } catch (e) {
      print("Error fetching shelf name: $e");
      setState(() {
        shelfName = "오류 발생";
      });
    }
  }

  Future<void> fetchFoodData(String shelfSerial) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('FOOD_MANAGEMENT')
          .where('smart_shelf_serial', isEqualTo: shelfSerial)
          .get();

      setState(() {
        foodData = snapshot.docs.map((doc) {
          final data = doc.data();
          return {
            ...data,
            'id': doc.id,
            'food_weight_update_time': data['food_weight_update_time'] is Timestamp
                ? (data['food_weight_update_time'] as Timestamp).toDate()
                : data['food_weight_update_time'],
            'food_register_date': data['food_register_date'] is Timestamp
                ? (data['food_register_date'] as Timestamp).toDate()
                : data['food_register_date'],
            'food_expiration_date': data['food_expiration_date'] != null &&
                data['food_expiration_date'] is Timestamp
                ? (data['food_expiration_date'] as Timestamp).toDate()
                : null,
          };
        }).toList();
      });

      if (foodData.isEmpty) {
        _showNoDataDialog();
      }
    } catch (e) {
      print("Error fetching food data: $e");
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

    final lastUpdatedTime = cellData['food_weight_update_time'];
    if (lastUpdatedTime == null || lastUpdatedTime is! DateTime) {
      return Colors.white;
    }

    final isUnused = DateTime.now()
        .difference(lastUpdatedTime)
        .inDays >=
        (cellData['food_unused_notif_period'] ?? 0);

    if (isUnused) return Color(0xFFF0D0FF);
    if (cellData['food_weight'] != 0) return Color(0xFFB4E0FF);
    return Color(0xFFFFA68B);
  }

  Color _getHighlightedColor(Color baseColor) {
    if (baseColor == Color(0xFFF0D0FF)) return Color(0xFFBA35FF);
    if (baseColor == Color(0xFFB4E0FF)) return Color(0xFF2DA9FF);
    if (baseColor == Color(0xFFFFA68B)) return Color(0xFFFF693C);
    return baseColor;
  }

  double _calculateInfoDialogPosition() {
    try {
      final RenderBox? box = infoButtonKey.currentContext?.findRenderObject() as RenderBox?;
      if (box != null) {
        final Offset position = box.localToGlobal(Offset.zero);
        return position.dy + box.size.height;
      }
    } catch (e) {
      print("Error calculating dialog position: $e");
    }
    return MediaQuery.of(context).size.height * 0.1;
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
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            '${shelfName}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Spacer(),
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
                    (food) => food['food_location'].any(
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
                key: ValueKey(food['id']),
                endActionPane: ActionPane(
                  motion: StretchMotion(),
                  children: [
                    CustomSlidableAction(
                      onPressed: (context) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodDetailPage(foodData: food),
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
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    '취소',
                                    style: TextStyle(color: Color(0xFF23778F)),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      foodData.removeAt(index);
                                    });
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("${food['food_name']} 삭제됨")),
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
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              food['food_name'],
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
                        Icon(
                          Icons.arrow_forward_ios,
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
