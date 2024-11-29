import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodDetailPage extends StatefulWidget {
  final Map<String, dynamic> foodData; // FoodList에서 전달받은 데이터

  FoodDetailPage({required this.foodData});

  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  late String shelfName;
  late String foodName;
  late DateTime foodRegisterDate;
  late int storageDays;
  late TextEditingController foodExpirationDate;
  late bool isExpiryToggle;
  late bool isNotificationToggle;
  late String foodUnusedNotifPeriod;

  final List<String> notificationOptions = [
    "1주일",
    "1개월",
    "2개월",
    "3개월",
    "6개월",
    "12개월",
  ];

  String? notificationMessage;
  bool isEditing = false; // 편집 모드 상태

  @override
  void initState() {
    super.initState();
    // FoodList에서 전달받은 데이터로 초기화
    final foodData = widget.foodData;
    shelfName = foodData['smart_shelf_name'] ?? '선반 1';
    foodName = foodData['food_name'] ?? '식품 이름 없음';
    foodRegisterDate = foodData['food_register_date']; // 이미 DateTime으로 변환됨
    foodUnusedNotifPeriod = "${foodData['food_unused_notif_period'] ?? '1'}일";
    storageDays = 0; // 초기값 설정
    foodExpirationDate = TextEditingController(
      text: foodData['food_expiration_date'] != null
          ? foodData['food_expiration_date']!.toIso8601String() // DateTime을 문자열로 변환
          : '',
    );
    isExpiryToggle = foodData['food_is_expiry'] ?? false;
    isNotificationToggle = foodData['food_is_notif'] ?? true;

    // 안내 메시지 초기화
    notificationMessage = "$foodUnusedNotifPeriod 이상 사용하지 않으면 알림을 받아요.";
    calculateStorageDays(); // 보관일수 계산
  }

  void calculateStorageDays() {
    DateTime currentDate = DateTime.now(); // 현재 날짜
    setState(() {
      storageDays = currentDate.difference(foodRegisterDate).inDays; // 날짜 차이를 계산하여 저장
    });
  }

  Future<void> _updateFoodData() async {
    try {
      // Firestore 업데이트 로직
      final foodDocId = widget.foodData['id']; // FoodList에서 전달받은 문서 ID
      await FirebaseFirestore.instance
          .collection('FOOD_MANAGEMENT') // 컬렉션 이름
          .doc(foodDocId) // 문서 ID
          .update({
        'food_name': foodName,
        'food_expiration_date': foodExpirationDate.text.isNotEmpty
            ? DateTime.parse(foodExpirationDate.text) // 문자열을 DateTime으로 변환
            : null,
        'food_is_expiry': isExpiryToggle,
        'food_is_notif': isNotificationToggle,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('데이터가 성공적으로 업데이트되었습니다!')),
      );
    } catch (e) {
      print("Error updating food data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('데이터 업데이트 중 오류가 발생했습니다.')),
      );
    }
  }

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
      "${result.substring(0, 4)}-${result.substring(4, 6)}-${result.substring(6, 8)}";
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
        title: Text(
          shelfName,
          style: TextStyle(fontSize: 18),
        ),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(
                    isEditing ? Icons.check : Icons.edit,
                    color: Color(0xFF23778F),
                  ),
                  onPressed: () {
                    setState(() {
                      if (isEditing) {
                        _updateFoodData(); // Firestore 업데이트 호출
                      }
                      isEditing = !isEditing; // 편집 모드 토글
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            _buildBoxWithWidget(
              "등록일",
              Text(
                  "${foodRegisterDate.year}년 ${foodRegisterDate.month}월 ${foodRegisterDate.day}일",
                  style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 20),
            _buildBoxWithWidget(
                "보관일수", Text("+$storageDays일", style: TextStyle(fontSize: 16))),
            // 나머지 UI 구성 요소는 그대로 유지
          ],
        ),
      ),
    );
  }
}
