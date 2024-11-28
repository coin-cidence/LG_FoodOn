import 'package:flutter/material.dart';

class FoodDetailPage extends StatefulWidget {
  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  String shelfLocation = "선반 1";
  String foodName = "가지"; // 식품 이름
  DateTime foodRegisterDate = DateTime(2024, 11, 20);
  int storageDays = 0;
  TextEditingController foodExpirationDate = TextEditingController();
  bool isExpiryToggle = false;
  bool isNotificationToggle = true;
  String foodUnusedNotifPeriod = "1주일";

  bool isEditing = false; // 편집 모드 상태

  final List<String> notificationOptions = [
    "1주일",
    "1개월",
    "2개월",
    "3개월",
    "6개월",
    "12개월",
  ];

  String? notificationMessage;

  // 초기 설정
  @override
  void initState() {
    super.initState();
    notificationMessage = "$foodUnusedNotifPeriod 이상 사용하지 않으면 알림을 받아요.";
    foodExpirationDate.text = ""; // 초기 유통기한 텍스트는 빈 값
    calculateStorageDays(); // 보관일수 계산
  }


  void calculateStorageDays() {
    DateTime currentDate = DateTime.now(); // 현재 날짜
    setState(() {
      storageDays = currentDate.difference(foodRegisterDate).inDays; // 날짜 차이를 계산하여 저장
    });
  }

  // 날짜 입력 포맷
  void _onExpiryDateChanged(String value) {
    String filteredValue = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (filteredValue.length <= 8) {
      final formattedValue = _formatExpiryDate(filteredValue);
      setState(() {
        foodExpirationDate.text = formattedValue;
      });

      int cursorPosition = foodExpirationDate.selection.base.offset;
      foodExpirationDate.selection =
          TextSelection.fromPosition(TextPosition(offset: cursorPosition));

      if (formattedValue.length == 10) {
        setState(() {
          isExpiryToggle = true;
        });
      }
    } else {
      foodExpirationDate.text = foodExpirationDate.text.substring(0, 10);
    }
  }

  String _formatExpiryDate(String value) {
    String result = value;

    if (result.length >= 5 && result.length <= 6) {
      result = "${result.substring(0, 4)}-${result.substring(4, 6)}";
    } else if (result.length >= 7 && result.length <= 8) {
      result =
      "${result.substring(0, 4)}-${result.substring(4, 6)}-${result.substring(
          6, 8)}";
    }

    return result;
  }

  Widget _buildBoxWithWidget(String label, Widget widget) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 25.0),
          Expanded(child: widget),
        ],
      ),
    );
  }


  @override
  void dispose() {
    foodExpirationDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(shelfLocation, style: TextStyle(fontSize: 18),),
        titleSpacing: 0,  // title과 leading 아이콘 사이의 기본 공백을 제거합니다.
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //선반이름과 식품 이름 정렬
                isEditing
                    ? Expanded(
                  child: TextField(
                    controller: TextEditingController(text: foodName),
                    decoration: InputDecoration(
                      hintText: "식품 이름을 입력하세요",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        foodName = value;
                      });
                    },
                  ),
                )
                    : Text(
                  foodName.isEmpty ? "식품 이름을 입력하세요" : foodName,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(
                    isEditing ? Icons.check : Icons.edit,
                    color: Color(0xFF23778F),
                  ),
                  onPressed: () {
                    setState(() {
                      isEditing = !isEditing; // 편집 모드 토글
                    });
                    if (!isEditing) {
                      // 편집이 끝나면 텍스트가 업데이트되도록 한다.
                      // (즉, 수정된 foodName을 그대로 유지)
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            _buildBoxWithWidget(
              "등록일",
              Text(foodRegisterDate != null
                  ? "${foodRegisterDate!.year}년 ${foodRegisterDate!
                  .month}월 ${foodRegisterDate!.day}일"
                  : "YYYY-MM-DD", style: TextStyle(fontSize: 16)),

            ),
            SizedBox(height: 20),
            _buildBoxWithWidget("보관일수", Text("+$storageDays일", style: TextStyle(fontSize: 16))),
            SizedBox(height: 20),
            _buildBoxWithWidget(
              "유통기한",
              Row(
                children: [
                  // 유통기한 텍스트 필드의 너비를 줄이고 중앙 정렬
                  Container(
                    width: 130, // 텍스트 필드의 너비를 줄임
                    child: TextField(style: TextStyle(fontSize: 16),
                      controller: foodExpirationDate,
                      decoration: InputDecoration(
                        hintText: "YYYY-MM-DD",
                        border: isEditing
                            ? OutlineInputBorder() //편집 모드일 때만 입력 가능
                            : InputBorder.none, // 비활성화 상태일 때 테두리 제거
                      ),
                      onChanged: _onExpiryDateChanged,
                      keyboardType: TextInputType.number,
                      enabled: isEditing, // 편집 모드일 때만 입력 가능
                      textAlign: TextAlign.center, // 텍스트 중앙 정렬
                    ),
                  ),
                  Spacer(), // Switch를 오른쪽 끝으로 밀어내는 Spacer
                  Switch(
                    value: isExpiryToggle,
                    onChanged: (value) {
                      setState(() {
                        isExpiryToggle = value;
                      });
                    },
                    activeColor: Colors.white, // 활성 상태의 토글 색상
                    activeTrackColor: Color(0xFF23778F), // 활성 상태의 트랙 색상
                    inactiveThumbColor: Colors.white, // 비활성 상태의 토글 색상
                    inactiveTrackColor: Color(0xFF808080), // 비활성 상태의 트랙 색상
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildBoxWithWidget(
              "장기 미사용 알림",
              Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: foodUnusedNotifPeriod,
                      style: TextStyle(fontSize: 16),
                      onChanged: isEditing
                          ? (String? newValue) {
                        setState(() {
                          foodUnusedNotifPeriod = newValue!;
                          //문자열 보간을 통해 안내 문구 설정
                          notificationMessage =
                              "$foodUnusedNotifPeriod 이상 사용하지 않으면 알림을 받아요.";
                        });
                      }
                          : null, // 편집 모드일 때만 활성화
                      items: notificationOptions
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                    Switch(
                        value: isNotificationToggle,
                        onChanged: (value) {
                          setState(() {
                            isNotificationToggle = value;
                          });
                        },
                      activeColor: Colors.white, // 활성 상태의 토글 색상
                      activeTrackColor: Color(0xFF23778F), // 활성 상태의 트랙 색상
                      inactiveThumbColor: Colors.white, // 비활성 상태의 토글 색상
                      inactiveTrackColor: Color(0xFF808080), // 비활성 상태의 트랙 색상
                      ),
                    ],
                  ),
                ]
              ),
            ),
            if (notificationMessage != null)
              Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 10.0),
              child: Text(
                notificationMessage!,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF808080),
                ),
              ),
            ),
            SizedBox(height: 20),
            // "식품 삭제" 버튼을 편집 상태일 때만 비활성화
            if (!isEditing)
              _buildBoxWithWidget(
                "",
                GestureDetector(
                  onTap: () {
                    // 삭제 로직 (예: 다이얼로그 표시)
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('삭제 확인', style: TextStyle(fontSize: 16)),
                          content: Text('해당 식품을 삭제하시겠습니까?',
                              style: TextStyle(fontSize: 14)),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('취소', style: TextStyle(color: Color(0xFF23778F)
                              )),
                            ),
                            TextButton(
                              onPressed: () {
                                // 삭제 작업 수행 후 처리
                                Navigator.of(context).pop();
                              },
                              child: Text('삭제', style: TextStyle(color: Color(0xFFD93512)
                              )),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0), // 박스 높이를 줄임
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // 텍스트와 아이콘 중앙 정렬
                      crossAxisAlignment: CrossAxisAlignment.center, // 수직 중앙 정렬
                      children: [
                        Text(
                          "식품 삭제",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFD93512)
                          ),
                        ),
                        SizedBox(width: 21.0), // 아이콘과 텍스트 사이의 간격을 줄임
                        // Icon(
                        //   Icons.delete,
                        //   color: Color(0xFFA50534)
                        //   ,
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}