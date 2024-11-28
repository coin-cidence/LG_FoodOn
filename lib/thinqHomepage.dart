import 'package:flutter/material.dart';
import 'deviceSelectionPage.dart';
import 'MessagePage.dart';
import 'widgets/my_custom_container.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isPowerOn = true; // 냉장고 전원 상태
  List<Map<String, dynamic>> devices = []; // 디바이스 목록
  List<Map<String, dynamic>> messages = [];

  // Bottom Sheet 표시
  // Bottom Sheet를 표시하는 함수
  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Bottom Sheet의 높이를 조정 가능하게 설정
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20), // 라운드 적용
        ),
      ),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Color(0xFFF0F1F5), // 배경색 설정
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20), // 라운드 유지
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 상단 바 이미지
              Center(
                child: Container(
                  width: 40, // 바의 너비
                  height: 4, // 바의 높이
                  margin: EdgeInsets.only(bottom: 12), // 추가 단어와의 간격
                  decoration: BoxDecoration(
                    color: Color(0xFFCAD0DE), // 바 색상
                    borderRadius: BorderRadius.circular(10), // 바의 둥근 모서리
                  ),
                ),
              ),
              // 타이틀
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 16), // 추가 단어 위로 패딩
                child: Text(
                  '추가',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'LGText',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // 첫 번째 그룹: 제품 추가
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Image.asset(
                    'images/image_home/plus.png', // 제품 추가를 위한 이미지 경로
                    width: 24, // 이미지 너비
                    height: 24, // 이미지 높이
                  ),
                  title: Text(
                    '제품 추가',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'LGText',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  subtitle: Text(
                    'LG, 삼성 등',
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'LGText',
                      fontWeight: FontWeight.w400,
                      height: 0.6, // 줄 간격을 조정 (default는 1.2 ~ 1.4)
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _navigateToDeviceSelectionPage();
                    // print("제품 추가 버튼 클릭됨");
                  },
                ),
              ),
              SizedBox(height: 16),

              // 두 번째 그룹: 묶음
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Image.asset(
                        'images/image_home/smart_routine.png', // 제품 추가를 위한 이미지 경로
                        width: 24, // 이미지 너비
                        height: 24, // 이미지 높이
                      ),
                      title: Text(
                        '스마트 루틴 만들기',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'LGText',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 34.0), // 좌우 간격을 줄여 선 길이를 조정
                      child: Divider(height: 1, color: Colors.grey.shade200),
                    ),
                    ListTile(
                      leading: Image.asset(
                        'images/image_home/connect_home.png', // 제품 추가를 위한 이미지 경로
                        width: 24, // 이미지 너비
                        height: 24, // 이미지 높이
                      ),
                      title: Text(
                        '우리 단지 연결',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'LGText',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 34.0), // 좌우 간격을 줄여 선 길이를 조정
                      child: Divider(height: 1, color: Colors.grey.shade200),
                    ),
                    ListTile(
                      leading: Image.asset(
                        'images/image_home/3d_home_view.png', // 제품 추가를 위한 이미지 경로
                        width: 24, // 이미지 너비
                        height: 24, // 이미지 높이
                      ),
                      title: Text(
                        '3D 홈뷰 만들기',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'LGText',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              // 세 번째 그룹: 묶음
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Image.asset(
                        'images/image_home/plus.png', // 제품 추가를 위한 이미지 경로
                        width: 24, // 이미지 너비
                        height: 24, // 이미지 높이
                      ),
                      title: Text(
                        '방 만들기',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'LGText',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 34.0), // 좌우 간격을 줄여 선 길이를 조정
                      child: Divider(height: 1, color: Colors.grey.shade200),
                    ),
                    ListTile(
                      leading: Image.asset(
                        'images/image_home/invite_member.png', // 제품 추가를 위한 이미지 경로
                        width: 24, // 이미지 너비
                        height: 24, // 이미지 높이
                      ),
                      title: Text(
                        '멤버 초대',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'LGText',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 34.0), // 좌우 간격을 줄여 선 길이를 조정
                      child: Divider(height: 1, color: Colors.grey.shade200),
                    ),
                    ListTile(
                      leading: Image.asset(
                        'images/image_home/add_home.png', // 제품 추가를 위한 이미지 경로
                        width: 24, // 이미지 너비
                        height: 24, // 이미지 높이
                      ),
                      title: Text(
                        '새로운 홈 만들기',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'LGText',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context); // BottomSheet 닫기
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToDeviceSelectionPage() async {
    // DeviceSelectionPage에서 반환되는 데이터를 가져옴
    final Map<String, dynamic>? selectedDevice = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DeviceSelectionPage()),
    );

    // 반환된 데이터가 null이 아닌 경우 처리
    if (selectedDevice != null) {
      // 반환된 데이터가 Map<String, dynamic> 타입인지 확인
      if (selectedDevice is Map<String, dynamic>) {
        // 예상 데이터 형식에 맞게 처리
        setState(() {
          devices.add({
            "name": selectedDevice['name'], // 선택된 이름
            "image": selectedDevice['image'], // 선택된 이미지
            "isPowerOn": true, // 초기 전원 상태
          });
        });
      } else {
        // 예상과 다른 데이터 타입이 반환된 경우 로그 출력
        print("Unexpected data type received: $selectedDevice");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'USER 홈',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'LGText',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Image.asset(
              'images/image_home/arrow_down.png',
              width: 12,
              height: 12,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'images/image_home/plus-sign.png',
              width: 21,
              height: 21,
            ),
            onPressed: _showBottomSheet,
          ),
          IconButton(
            icon: Image.asset(
              'images/image_home/bell.png',
              width: 21,
              height: 21,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MessagePage(messages: messages),
                ),
              );
            },
          ),
          IconButton(
            icon: Image.asset(
              'images/image_home/dots.png',
              width: 21,
              height: 21,
            ),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/image_home/background_gradation.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 77),
                    Image.asset(
                      'images/image_home/home_home.png',
                      width: 73,
                      height: 73,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '홈 위치를 설정하면 맞춤 정보와 기능을 사용할 수 있어요.',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'LGText',
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        '설정하기',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'LGText',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF23778F),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                        minimumSize: Size(80, 35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '스마트 루틴',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'LGText',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 6),
                          ElevatedButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 6.0, right: 6.0),
                                  child: Image.asset(
                                    'images/image_home/문.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                Text(
                                  '루틴 알아보기',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'LGText',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              elevation: 0,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            '거실',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'LGText',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 6),
                          // 거실에 냉장고 및 추가된 디바이스 표시
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, // 간격 균등하게 조정
                            children: [
                              // 냉장고 UI
                              Flexible(
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.45,
                                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            'images/product_image/냉장고.png',
                                            width: 55,
                                            height: 55,
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            '냉장고',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'LGText',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(height: 1),
                                          Text(
                                            isPowerOn ? '켜짐' : '꺼짐',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'LGText',
                                              fontWeight: FontWeight.w400,
                                            ),
                                            textAlign: TextAlign.left, // 텍스트 정렬 추가 (왼쪽 정렬)
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        top: 5,
                                        right: 5,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isPowerOn = !isPowerOn;
                                            });
                                          },
                                          child: Image.asset(
                                            isPowerOn
                                                ? 'images/image_home/power_on.png'
                                                : 'images/image_home/power_off.png',
                                            width: 35,
                                            height: 35,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // 추가된 디바이스 UI
                              ...devices.map((device) {
                                return Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      // my_custom_container.dart 호출 현지 수정
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MyCustomContainer(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.45,
                                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Stack(
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                device["image"] ?? '',
                                                width: 55,
                                                height: 55,
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                device["name"] ?? '',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'LGText',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                textAlign: TextAlign.left, // 텍스트 정렬 추가 (왼쪽 정렬)
                                              ),
                                              SizedBox(height: 1),
                                              Text(
                                                (device["isPowerOn"] ?? true) ? '켜짐' : '꺼짐',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'LGText',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                textAlign: TextAlign.left, // 텍스트 정렬 추가 (왼쪽 정렬)
                                              ),
                                            ],
                                          ),
                                          Positioned(
                                            top: 5,
                                            right: 5,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  device["isPowerOn"] = !(device["isPowerOn"] ?? true); // 상태 변경
                                                });
                                              },
                                              child: Image.asset(
                                                (device["isPowerOn"] ?? true)
                                                    ? 'images/image_home/power_on.png'
                                                    : 'images/image_home/power_off.png', // 상태 기반 이미지
                                                width: 35,
                                                height: 35,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),

                            ],
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Color(0xFFECF7F9),
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                    child: Image.asset(
                      'images/image_home/home_button.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  label: '홈',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                    child: Image.asset(
                      'images/image_home/discover_button.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  label: '디스커버',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                    child: Image.asset(
                      'images/image_home/report_button.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  label: '리포트',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                    child: Image.asset(
                      'images/image_home/menu_button.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  label: '메뉴',
                ),
              ],
              unselectedLabelStyle: TextStyle(
                fontFamily: 'LGText',
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
            ),
          ],
        ),
      ),
    );
  }
}