import 'package:flutter/material.dart';

class DeviceSelectionPage extends StatefulWidget {
  @override
  _DeviceSelectionPageState createState() => _DeviceSelectionPageState();
}

class _DeviceSelectionPageState extends State<DeviceSelectionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // 전체 디바이스 리스트
  final List<Map<String, String>> _deviceList = [
    {'name': '냉장고', 'image': 'images/image_home/fridge.png'},
    {'name': '스마트 선반', 'image': 'images/image_home/smart_shelf.png'},
    {'name': '에어컨', 'image': 'images/image_home/air_conditioner.png'},
    {'name': '세탁기', 'image': 'images/image_home/washing_machine.png'},
    {'name': 'TV', 'image': 'images/image_home/tv.png'},
  ];

  // 내가 가진 디바이스
  final List<String> _myDevices = ['냉장고'];

  List<Map<String, String>> _filteredMyDevices = [];
  List<Map<String, String>> _filteredOtherDevices = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // 초기 필터링
    _filterDevices('');
  }

  void _filterDevices(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredMyDevices = _deviceList
            .where((device) => _myDevices.contains(device['name']))
            .toList();
        _filteredOtherDevices = _deviceList
            .where((device) => !_myDevices.contains(device['name']))
            .toList();
      } else {
        _filteredMyDevices = _deviceList
            .where((device) =>
        _myDevices.contains(device['name']) &&
            device['name']!.contains(query))
            .toList();
        _filteredOtherDevices = _deviceList
            .where((device) =>
        !_myDevices.contains(device['name']) &&
            device['name']!.contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("추가할 디바이스를 선택하세요."),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "LG"),
            Tab(text: "다른 브랜드"),
          ],
        ),
      ),
      body: Column(
        children: [
          // 검색창
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterDevices,
              decoration: InputDecoration(
                hintText: "디바이스 이름 검색",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          // 내가 가진 디바이스 섹션
          if (_filteredMyDevices.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "My Devices",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filteredMyDevices.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.asset(
                          _filteredMyDevices[index]['image']!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(_filteredMyDevices[index]['name']!),
                        onTap: () {
                          Navigator.pop(context, _filteredMyDevices[index]['name']);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          // 기타 디바이스 섹션
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredOtherDevices.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.asset(
                            _filteredOtherDevices[index]['image']!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(_filteredOtherDevices[index]['name']!),
                          onTap: () {
                            Navigator.pop(context, _filteredOtherDevices[index]['name']);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
