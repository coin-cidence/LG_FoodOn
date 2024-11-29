import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'FoodDetailPage.dart';
import 'info_dialog.dart';
import 'firestore_service.dart';


class FoodListPage extends StatefulWidget {
  final String shelfSerial;

  FoodListPage({required this.shelfSerial});

  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  late String selectedShelf;
  late String selectedShelfSerial;
  String? shelfName;
  List<Map<String, dynamic>> allFoodData = []; // 전체 데이터를 저장
  List<Map<String, dynamic>> filteredFoodData = []; // 필터된 데이터를
  List<Map<String, int>> highlightedLocations = [];
  bool _isInfoVisible = false;
  GlobalKey infoButtonKey = GlobalKey();
  final FirestoreService firestoreService = FirestoreService();
  String selectedFilter = "가나다순"; // 기본 필터값

  @override
  void initState() {
    super.initState();
    selectedShelfSerial = widget.shelfSerial;
    print('목록에 ShelfSerial: $selectedShelfSerial'); // 값 출력

    fetchShelfName(selectedShelfSerial);
    _fetchAllFoodData(selectedShelfSerial);
    // _applyFilter(selectedFilter);
  }

  // Firestore에서 선반 이름 가져오기
  Future<void> fetchShelfName(String shelfSerial) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('SMART_SHELF')
          .where('smart_shelf_serial', isEqualTo: shelfSerial)
          // .orderBy('smart_shelf_name') // 이름으로 정렬
          .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          shelfName = snapshot.docs.first['smart_shelf_name'];
          print('선반 이름: $shelfName');
        });
      } else {
        setState(() {
          shelfName = "이름 없음";
          print('SMART_SHELF에 데이터가 없음');
        });
      }
    } catch (e) {
      print("Error fetching shelf name: $e");
      setState(() {
        shelfName = "오류 발생";
      });
    }
  }

  // 모든 데이터를 한 번만 가져옴
  Future<void> _fetchAllFoodData(String shelfSerial) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('FOOD_MANAGEMENT')
          .where('smart_shelf_serial', isEqualTo: shelfSerial)
          .get();
      print('Firestore 쿼리 결과: ${snapshot.docs.length}개');

      setState(() {
        allFoodData = snapshot.docs.map((doc) {
          final data = doc.data();
          return {
            ...data,
            'food_name': data['food_name'],
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
        print('allFoodData 설정 완료: ${allFoodData.length}개');

        // 데이터가 설정된 후에만 필터 적용
        _applyFilter(selectedFilter);
      });
    } catch (e) {
      print("Error fetching food data: $e");
      _showNoDataDialog();
    }
  }

  void _applyFilter(String filter) {
    if (allFoodData.isEmpty) {
      print('allFoodData가 비어 있어 필터를 적용하지 않음');
      return;
    }

    List<Map<String, dynamic>> filteredData = List.from(allFoodData);

    // 필터 조건에 따라 정렬 및 필터링
    switch (filter) {
      case "가나다순":
        filteredData.sort((a, b) => a['food_name'].toString().compareTo(b['food_name'].toString()));
        break;
      case "오래된순":
        filteredData.sort((a, b) => a['food_register_date'].compareTo(b['food_register_date']));
        break;
      case "장기미사용식품":
        filteredData = filteredData.where((food) {
          final daysSinceUpdate = DateTime.now().difference(food['food_weight_update_time']).inDays;
          return daysSinceUpdate >= food['food_unused_notif_period'];
        }).toList();
        break;
    }

    setState(() {
      filteredFoodData = filteredData; // 필터된 데이터를 저장
      print('filteredFoodData 길이: ${filteredFoodData.length}');

    });
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

    if (isUnused) return Color(0xFFF0D0FF); // 보라색
    if (cellData['food_weight'] != 0) return Color(0xFFB4E0FF); // 파란색
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

  void _showNoDataDialog() {
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,  // 배경색을 하얀색으로 설정
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),  // 모서리를 둥글게 만드는 부분
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 데이터가 비어 있다면 다이얼로그를 호출
    if (allFoodData.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        print('너 뭔데');
        _showNoDataDialog();
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 30, // 아이콘 크기 조정
            color: Colors.black, // 아이콘 색상 설정
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Transform.translate(
              offset: Offset(-30, 0), // 왼쪽으로 30 이동
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8), // 내부 여백
                /*child: DropdownButton<String>(
                  underline: SizedBox.shrink(), // 밑줄 제거
                  iconSize: 20, // 아이콘 크기 설정

                  // 데이터를 정렬된 순서로 가져옴
                  final shelves = snapshot.data!;
                  shelves.sort((a, b) => a['shelfName'].compareTo(b['shelfName'])); // 이름으로 정렬

                  value: shelfName,
                  items: shelves.map((selectedShelfSerial) {
                    return DropdownMenuItem<String>(
                      value:
                      '${shelfName}',
                      child: Text(
                        '${shelfName}',
                        style: TextStyle(color: Colors.black), // 드롭다운 텍스트 색상 설정
                      ),
                    );
                  }).toList(),
                  dropdownColor: Color(0xFFFFFFFF),
                  onChanged: (value) {
                    setState(() {
                      shelfName = value!;
                      highlightedLocations = [];
                      filteredFoodData = List.from(allFoodData);
                    });
                  },
                ),*/
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: firestoreService.fetchSmartShelvesData(selectedShelfSerial), // Firestore에서 데이터 로드
                  builder: (context, snapshot) {
                    print('헤이전달된 selectedShelfSerial: $selectedShelfSerial');

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // 로딩 중 표시
                    }
                    if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text("선반 없음", style: TextStyle(fontSize: 20, color: Colors.black)); // 오류 또는 데이터 없음 처리
                    }

                    // 데이터를 정렬된 순서로 가져옴
                    final shelves = snapshot.data!;
                    shelves.sort((a, b) => a['shelfName'].compareTo(b['shelfName'])); // 이름으로 정렬

                    return DropdownButton<String>(
                      underline: SizedBox.shrink(), // 밑줄 제거
                      iconSize: 20, // 아이콘 크기 설정
                      value: shelfName,
                      items: shelves.map((shelf) {
                        return DropdownMenuItem<String>(
                          value: shelf['shelfName'],
                          child: Text(
                            shelf['shelfName'], // 드롭다운 텍스트
                            style: TextStyle(color: Colors.black), // 드롭다운 텍스트 색상 설정
                          ),
                        );
                      }).toList(),
                      dropdownColor: Color(0xFFFFFFFF),
                      onChanged: (value) {
                        setState(() {
                          shelfName = value!; // 선택된 선반 이름 업데이트
                          highlightedLocations = [];
                          filteredFoodData = List.from(allFoodData); // 필요한 데이터 업데이트
                        });
                      },
                    );
                  },
                ),
              ),
            ),
            Spacer(), // 왼쪽과 오른쪽 정렬을 위한 Spacer
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            ),
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
      ),
      body: Stack(
        children: [
          _buildBackground(),
          SafeArea( // 콘텐츠가 안전한 위치에 배치되도록 함
            child: Column(
              children: [
                _buildGridArea(screenWidth),
                _buildListArea(screenWidth),
              ],
            ),
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
                    (food) => food['food_location'].any((loc) => loc['x'] == row && loc['y'] == column),
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
                            (food) => food['food_location'].any(
                              (loc) => loc['x'] == row && loc['y'] == column,
                        ),
                        orElse: () => <String, dynamic>{},
                      );

                      if (selectedFood.isNotEmpty) {
                        if (highlightedLocations.isNotEmpty &&
                            highlightedLocations.every(
                                  (loc) => selectedFood['food_location'].contains(loc),
                            )) {
                          highlightedLocations = [];
                          filteredFoodData = List.from(allFoodData);
                        } else {
                          highlightedLocations = List<Map<String, int>>.from(selectedFood['food_location']);
                          filteredFoodData = allFoodData.where((food) {
                            return food['food_location'].any((loc) =>
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
          alignment: Alignment.center,
          underline: SizedBox.shrink(), // 밑줄 제거
          iconSize:20,
          value: selectedFilter,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Color(0xFF8D9294),
          ),
          items: ["가나다순", "오래된순", "장기미사용식품"].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF8D9294),
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
    double listItemWidth = double.infinity; // 초기 너비 값

    return Slidable(
      key: ValueKey(food['food_name']),
      endActionPane: ActionPane(
        motion: StretchMotion(),
        extentRatio: 0.5, // 슬라이드 시 버튼 영역 비율
        children: [
          Expanded(
            child: CustomSlidableButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodDetailPage(foodData: {},),
                  ),
                ).then((deletedFoodName) { // 나린 추가한 부분 - FoodDetailPage에서 삭제 시 삭제
                  if (deletedFoodName != null) {
                    setState(() {
                      // 삭제된 식품명을 기준으로 데이터 제거
                      allFoodData.removeWhere((food) => food['food_name'] == deletedFoodName);
                      filteredFoodData.removeWhere((food) => food['food_name'] == deletedFoodName);
                    });
                  }
                });
              },
              icon: Icons.info,
              iconColor: Colors.blue,
              backgroundColor: Colors.white,
            ),
          ),
          // 오른쪽 버튼 (삭제)
          Expanded(
            child: CustomSlidableButton(
              onPressed: () {
                _showDeleteDialog(index);
              },
              icon: Icons.delete,
              iconColor: Colors.red,
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            // 현재 하이라이트 된 위치가 이미 포함되어 있는지 확인
            if (highlightedLocations.any((loc) => food['food_location'].contains(loc))) {
              // 포함되어 있다면 하이라이트 해제
              highlightedLocations.removeWhere((loc) => food['food_location'].contains(loc));
            } else {
              // 포함되어 있지 않다면 하이라이트 추가
              highlightedLocations = List<Map<String, int>>.from(food['food_location']);
            }
          });
        },
        child: Container(
        // width: double.infinity,
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
                  food['food_name'],
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
          backgroundColor: Colors.white,  // 배경색을 하얀색으로 설정
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),  // 모서리를 둥글게 만드는 부분
          ),
          title: Text('삭제 확인'),
          content: Text('해당 식품을 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('취소', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // 삭제할 식품의 위치 정보를 가져옴
                  final deletedFoodLocations = filteredFoodData[index]['food_location'];

                  // filteredFoodData에서 해당 항목 삭제
                  filteredFoodData.removeAt(index);

                  // allFoodData에서도 해당 항목을 삭제
                  allFoodData.removeWhere((food) => food['food_location'] == deletedFoodLocations);

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


class CustomSlidableButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const CustomSlidableButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 55, // 버튼 너비
        height: 55, // 버튼 높이
        margin: const EdgeInsets.only(left: 20), // 왼쪽에만 10의 마진 추가
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(5), // 모서리 둥글게
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
          icon,
          color: iconColor,
          size: 25,
        ),
      ),
    );
  }
}