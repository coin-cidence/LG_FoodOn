import 'package:flutter/material.dart';
import 'info_dialog.dart';

class FoodListPage extends StatefulWidget {
  final String shelfName; // 선택된 선반 이름

  FoodListPage({required this.shelfName}); // 생성자에서 선반 이름 전달받음

  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  late String selectedShelf; // 현재 선택된 선반 이름
  bool _isInfoVisible = false; // 정보창 표시 여부
  GlobalKey infoButtonKey = GlobalKey(); // Key for info button to find position

  @override
  void initState() {
    super.initState();
    selectedShelf = widget.shelfName; // 초기값으로 전달받은 선반 이름 설정
  }

  // 강조 표시할 좌표 정보
  final List<List<int>> highlightedCoordinates = [
    [3, 2], [3, 3], [3, 4], [3, 5],
    [4, 1], [4, 2], [4, 3], [4, 4], [4, 5],
    [5, 2], [5, 3], [5, 4],
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // 화면 너비의 80%를 차지하도록 설정
    final gridWidth = screenWidth * 0.8;
    // 가로 셀 개수
    final columns = 11;
    // 각 셀의 크기 (1:1 비율을 유지하기 위해 gridWidth를 기준으로 계산)
    final cellSize = gridWidth / columns;

    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지 설정
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/FTIE_엘지배경_대지.png'), // 배경 이미지 경로
                fit: BoxFit.cover, // 이미지가 화면 전체를 덮도록 설정
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top), // 상태바 공간
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    DropdownButton<String>(
                      value: selectedShelf,
                      items: ["선반 1", "선반 2", "선반 3", "선반 4"].map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedShelf = value!;
                        });
                      },
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {},
                        ),
                        IconButton(
                          key: infoButtonKey, // Assign key for positioning
                          icon: Icon(Icons.info),
                          onPressed: () {
                            final RenderBox box = infoButtonKey.currentContext!
                                .findRenderObject() as RenderBox;
                            final Offset position = box.localToGlobal(Offset.zero);
                            setState(() {
                              _isInfoVisible = !_isInfoVisible; // Toggle visibility
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 6, // 상단 영역: 60% 높이
                child: Center(
                  child: Container(
                    width: gridWidth, // 그리드가 화면의 80% 너비를 차지
                    child: Stack(
                      children: List.generate(11 * 17, (index) {
                        final row = index ~/ columns; // 세로 (행)
                        final column = index % columns; // 가로 (열)

                        // 강조 표시 여부 확인
                        final isHighlighted = highlightedCoordinates.any(
                              (coordinate) =>
                          coordinate[0] == row && coordinate[1] == column,
                        );

                        return Positioned(
                          left: column * cellSize, // 열 위치
                          top: row * cellSize, // 행 위치
                          child: Container(
                            width: cellSize * 0.9, // 셀 크기 (간격 포함, 90%)
                            height: cellSize * 0.9, // 셀 크기 (간격 포함, 90%)
                            decoration: BoxDecoration(
                              color: isHighlighted
                                  ? Colors.purple[200]
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
              Divider(height: 1, color: Colors.grey), // 구분선
              Expanded(
                flex: 4, // 하단 영역: 40% 높이
                child: ListView(
                  padding: EdgeInsets.all(8.0),
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.purple[200],
                        radius: 10,
                      ),
                      title: Text('가지'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue[200],
                        radius: 10,
                      ),
                      title: Text('감'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue[300],
                        radius: 10,
                      ),
                      title: Text('방울토마토'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.purple[100],
                        radius: 10,
                      ),
                      title: Text('사과'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // 정보창
          if (_isInfoVisible)
            InfoDialog(
              xPosition: MediaQuery.of(context).size.width / 2,
              yPosition: 100, // Adjusted for testing
            ),
        ],
      ),
    );
  }
}
