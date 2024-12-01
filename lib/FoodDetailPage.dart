import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // 날짜 포맷을 위한 패키지

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
  late TextEditingController foodNameController;
  late bool isExpiryToggle;
  late bool isNotificationToggle;
  late String foodUnusedNotifPeriod;
  late String originalFoodName;
  late String originalFoodUnusedNotifPeriod;

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
    originalFoodName = foodName;

    // food_register_date가 Timestamp일 경우 DateTime으로 변환, 아닐 경우 그대로 사용
    if (foodData['food_register_date'] is Timestamp) {
      foodRegisterDate = (foodData['food_register_date'] as Timestamp).toDate();
    } else if (foodData['food_register_date'] is DateTime) {
      foodRegisterDate = foodData['food_register_date'];
    } else {
      foodRegisterDate = DateTime.now();
    }

    // foodUnusedNotifPeriod 초기값 설정 - notificationOptions에 없으면 기본값 "1주일"로 설정
    String tempFoodUnusedNotifPeriod = "${foodData['food_unused_notif_period'] ?? "1주일"}";
    foodUnusedNotifPeriod = notificationOptions.contains(tempFoodUnusedNotifPeriod) ? tempFoodUnusedNotifPeriod : "1주일";
    notificationMessage = "$foodUnusedNotifPeriod 이상 사용하지 않으면 알림을 받아요.";
    originalFoodUnusedNotifPeriod = foodUnusedNotifPeriod;

    storageDays = 0; // 초기값 설정
    foodExpirationDate = TextEditingController(
      text: foodData['food_expiration_date'] != null
          ? (foodData['food_expiration_date'] is Timestamp
          ? DateFormat('yyyy년 MM월 dd일').format((foodData['food_expiration_date'] as Timestamp).toDate())
          : DateFormat('yyyy년 MM월 dd일').format(foodData['food_expiration_date']))
          : '',
    );

    foodNameController = TextEditingController(text: foodName);

    // 유통기한이 설정된 경우 알림 토글을 활성화
    if (foodExpirationDate.text.isNotEmpty) {
      isExpiryToggle = true;
    } else {
      isExpiryToggle = foodData['food_expir_notif'] ?? false;
    }

    isNotificationToggle = foodData['food_unused_notif'] ?? true;

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
      // Firestore에서 food_management_serial로 문서 찾기
      final snapshot = await FirebaseFirestore.instance
          .collection('FOOD_MANAGEMENT')
          .where('food_management_serial', isEqualTo: widget.foodData['food_management_serial'])
          .get();

      if (snapshot.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('해당 고유번호의 문서를 찾을 수 없습니다.')),
        );
        return;
      }

      final foodDocRef = snapshot.docs.first.reference;
      DateTime? expirationDate;

      if (foodExpirationDate.text.isNotEmpty) {
        try {
          // 문자열을 DateTime으로 변환 (입력 형식에 맞춰 변경)
          expirationDate = DateFormat('yyyy년 MM월 dd일').parse(foodExpirationDate.text);
        } catch (formatError) {
          throw FormatException('유효하지 않은 날짜 형식입니다: ${foodExpirationDate.text}');
        }
      }

      // Firestore 업데이트 로직
      await foodDocRef.update({
        'food_name': foodName,
        'food_expiration_date': expirationDate, // Firestore에는 DateTime으로 저장
        'food_expir_notif': isExpiryToggle,
        'food_unused_notif': isNotificationToggle,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('식품 정보가 성공적으로 업데이트되었습니다!')),
      );

      setState(() {
        widget.foodData['food_name'] = foodName;
        widget.foodData['food_expiration_date'] = expirationDate;
        widget.foodData['food_expir_notif'] = isExpiryToggle;
        widget.foodData['food_unused_notif'] = isNotificationToggle;
        isEditing = false; // 편집 모드 종료
      });
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
  //추가 함수
  void _showDeleteDialogForDetail() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            '삭제 확인',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          content: Text(
            '해당 식품을 삭제하시겠습니까?',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('취소', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                String deletedFoodName = foodName;
                Navigator.of(context).pop(); // 다이얼로그 닫기
                Navigator.of(context).pop(deletedFoodName); // 이전 화면에 데이터 반환
              },
              child: Text('삭제', style: TextStyle(color: Color(0xFFA50534))),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // 키보드에 의해 화면이 자동으로 조정되도록 설정
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/엘지배경_대지 1 3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
            child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight, // 전체 화면을 최소 높이로 설정
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery
                              .of(context)
                              .viewInsets
                              .bottom, // 키보드가 나타날 때 하단 패딩 적용
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              leading: IconButton(
                                icon: Icon(Icons.arrow_back, color: Colors.black),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              title: Text(
                                shelfName,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "LGText",
                                  color: Colors.black,
                                ),
                              ),
                              titleSpacing: 0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      isEditing
                                      ? Expanded(
                                        child: TextField(
                                          controller: foodNameController,
                                          decoration: InputDecoration(
                                            hintText: "식품 이름을 입력하세요",
                                            hintStyle: TextStyle(
                                              fontFamily: "LGText",
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey,
                                            ),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey.shade300,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              foodName = value;
                                            });
                                          },
                                        ),
                                      )
                                          : Text(
                                        foodName.isEmpty
                                            ? "식품 이름을 입력하세요"
                                            : foodName,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "LGText",
                                        ),
                                      ),
                                      if (!isEditing)
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isEditing = true;
                                              // _updateFoodData(); // Firestore 업데이트 호출
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Icon(Icons.edit,
                                                  size: 20, color: Colors.black),
                                              SizedBox(width: 1),
                                              Text(
                                                "편집",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF001F28),
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "LGText",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  _buildBoxWithWidget(
                                    "등록일",
                                    Text(
                                      "${foodRegisterDate.year}년 ${foodRegisterDate
                                          .month}월 ${foodRegisterDate.day}일",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "LGText",
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  _buildBoxWithWidget(
                                    "보관일수",
                                    Text(
                                      "+$storageDays일",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "LGText",
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  _buildBoxWithWidget(
                                    "유통기한",
                                    Row(
                                      children: [
                                        Container(
                                          width: 130,
                                          child: TextField(
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "LGText",
                                              color: isExpiryToggle
                                                  ? Colors.black
                                                  : Colors.grey, // 알림 상태에 따라 색상 설정
                                            ),
                                            controller: foodExpirationDate,
                                            decoration: InputDecoration(
                                              hintText: "YYYY년 MM월 DD일",
                                              hintStyle: TextStyle(
                                                fontFamily: "LGText",
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey,
                                              ),
                                              border: isEditing
                                                  ? OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade300,
                                                  width: 1.0,
                                                ),
                                              )
                                                  : InputBorder.none,
                                            ),
                                            onChanged: _onExpiryDateChanged,
                                            keyboardType: TextInputType.number,
                                            enabled: isEditing,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Spacer(),
                                        Switch(
                                          value: isExpiryToggle,
                                          onChanged: (value) {
                                            setState(() {
                                              isExpiryToggle = value;
                                            });
                                          },
                                          activeColor: Colors.white,
                                          activeTrackColor: Color(0xFF23778F),
                                          inactiveThumbColor: Colors.white,
                                          inactiveTrackColor: Color(0xFF808080),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  _buildBoxWithWidget(
                                    "장기 미사용 알림",
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: DropdownButton<String>(
                                                value: foodUnusedNotifPeriod,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "LGText",
                                                  color: isNotificationToggle
                                                      ? Colors.black
                                                      : Colors
                                                      .grey, // 알림 상태에 따라 색상 설정
                                                ),
                                                dropdownColor: Colors.white,
                                                elevation: 1,
                                                onChanged: isEditing
                                                    ? (String? newValue) {
                                                  setState(() {
                                                    foodUnusedNotifPeriod =
                                                    newValue!;
                                                    notificationMessage =
                                                    "$foodUnusedNotifPeriod 이상 사용하지 않으면 알림을 받아요.";
                                                  });
                                                }
                                                    : null,
                                                items: notificationOptions.map<
                                                    DropdownMenuItem<String>>((
                                                    String value) {
                                                  return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(
                                                          value,
                                                          style: TextStyle(
                                                            fontFamily: "LGText",
                                                            color: isNotificationToggle
                                                                ? Colors.black
                                                                : Colors
                                                                .grey, // 알림 상태에 따라 색상 설정
                                                          )
                                                      )
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
                                              activeColor: Colors.white,
                                              activeTrackColor: Color(0xFF23778F),
                                              inactiveThumbColor: Colors.white,
                                              inactiveTrackColor: Color(0xFF808080),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (notificationMessage != null)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, left: 10.0),
                                      child: Text(
                                        notificationMessage!,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isNotificationToggle
                                              ? Colors.black
                                              : Color(0xFF808080),
                                          // 알림 상태에 따라 색상 설정
                                          fontFamily: "LGText",
                                        ),
                                      ),
                                    ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      if (isEditing) ...[
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                // 이전 상태로 복원
                                                foodName = originalFoodName; // 원래 식품 이름 복원
                                                foodUnusedNotifPeriod = originalFoodUnusedNotifPeriod; // 원래 알림 설정 복원
                                                isEditing = false; // 편집 모드 종료
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              foregroundColor: Color(0xFFA50534),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    10),
                                              ),
                                              elevation: 0,
                                            ),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.symmetric(vertical: 14),
                                              child: Text(
                                                "취소",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "LGText",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: ElevatedButton(
                                            /*onPressed: () {
                                              setState(() {
                                                isEditing = false;
                                              });
                                            },*/
                                            onPressed: () async {
                                              _updateFoodData();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(0xFFA50534),
                                              foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              elevation: 0,
                                            ),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 14),
                                              child: Text(
                                                "편집 저장",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "LGText",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ] else...[
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                _showDeleteDialogForDetail();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(0xFFA50534),
                                                foregroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                elevation: 0,
                                              ),
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.symmetric(vertical: 14),
                                                child: Text(
                                                  "식품 삭제",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "LGText",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            )
        ),
      ),
    );
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
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: "LGText",
            ),
          ),
          SizedBox(width: 25.0),
          Expanded(child: widget),
        ],
      ),
    );
  }
