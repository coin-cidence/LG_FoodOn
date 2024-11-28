import 'package:flutter/material.dart';

class DeviceSelectionPage extends StatefulWidget {
  @override
  _DeviceSelectionPageState createState() => _DeviceSelectionPageState();
}

class _DeviceSelectionPageState extends State<DeviceSelectionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // 전체 제품 리스트
  final List<Map<String, dynamic>> _productList = [
    {'name': '세탁기', 'image': 'images/product_image/세탁기.png'},
    {'name': '건조기', 'image': 'images/product_image/건조기.png'},
    {'name': '냉장고', 'image': 'images/product_image/냉장고.png'},
    {'name': '에어컨', 'image': 'images/product_image/에어컨.png'},
    {'name': '스타일러', 'image': 'images/product_image/스타일러.png'},
    {'name': '에어로타워', 'image': 'images/product_image/에어로타워.png'},
    {'name': '공기청정기', 'image': 'images/product_image/공기청정기.png'},
    {'name': '슈케이스', 'image': 'images/product_image/슈케이스.png'},
    {'name': '식기세척기', 'image': 'images/product_image/식기세척기.png'},
    {'name': '푸디온', 'image': 'images/product_image/스마트선반.png'},
    {'name': '전자레인지', 'image': 'images/product_image/전자레인지.png'},
    {'name': '틔운', 'image': 'images/product_image/틔운.png'},
    {'name': '틔운미니', 'image': 'images/product_image/틔운미니.png'},
    {'name': '힐링미', 'image': 'images/product_image/힐링미.png'}
  ];

  // 내가 가진 모델 리스트
  final List<String> _myProducts = ['냉장고'];

  List<Map<String, dynamic>> _filteredMyProducts = [];
  List<Map<String, dynamic>> _filteredOtherProducts = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // 초기 필터링 설정
    _filterProducts('');
  }

  void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredMyProducts = _productList
            .where((product) => _myProducts.contains(product['name']))
            .toList();
        _filteredOtherProducts = _productList
            .where((product) => !_myProducts.contains(product['name']))
            .toList();
      } else {
        _filteredMyProducts = _productList
            .where((product) =>
        _myProducts.contains(product['name']) &&
            product['name']!.contains(query))
            .toList();
        _filteredOtherProducts = _productList
            .where((product) =>
        !_myProducts.contains(product['name']) &&
            product['name']!.contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F5),
      body: SafeArea(
        child: Column(
          children: [
            // 상단 고정 영역 (AppBar, TabBar)
            Container(
              color: const Color(0xFFF0F1F5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.black),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
                    child: Text(
                      "추가할 제품을 선택해주세요.",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold, // 볼드 폰트
                        fontFamily: 'LGText',
                      ),
                    ),
                  ),
                  TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: const [
                      SizedBox(
                        width: 150,
                        child: Tab(
                          child: Text(
                            "LG",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'LGText',
                              fontWeight: FontWeight.w600, // 레귤러 폰트
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Tab(
                          child: Text(
                            "다른 브랜드",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'LGText',
                              fontWeight: FontWeight.w600, // 레귤러 폰트
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // 검색창 및 스크롤 가능 영역
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 검색창
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: TextField(
                        onChanged: _filterProducts,
                        decoration: InputDecoration(
                          hintText: "제품명 또는 모델명 검색",
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 16,
                            fontFamily: 'LGText',
                            fontWeight: FontWeight.w600, // 세미볼드 폰트
                          ),
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    // My LG 섹션
                    if (_filteredMyProducts.isNotEmpty)
                      _buildProductSection("내 제품", _filteredMyProducts),
                    // Register 섹션
                    if (_filteredOtherProducts.isNotEmpty)
                      _buildProductSection("등록 가능", _filteredOtherProducts),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// 제품 리스트 섹션
  Widget _buildProductSection(
      String title, List<Map<String, dynamic>> productList) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 리스트 빌더
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context, productList[index]);
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          productList[index]['image']!,
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          productList[index]['name']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'LGText',
                            fontWeight: FontWeight.w400, // 레귤러 폰트
                          ),
                        ),
                      ],
                    ),
                    if (index != productList.length - 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Divider(
                          color: Colors.grey.shade200,
                          thickness: 1,
                          height: 8,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}