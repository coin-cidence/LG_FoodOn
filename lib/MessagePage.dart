import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'firestore_service.dart';

class MessagePage extends StatefulWidget {
  final List<Map<String, dynamic>> messages;

  MessagePage({required this.messages});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  // String shelfLocation = "선반 1";

  // 대한민국 시간(KST)으로 변환하는 함수
  DateTime convertToKST(DateTime dateTime) {
    final koreaTimeZoneOffset = Duration(hours: 9); // KST는 UTC+9
    return dateTime.toUtc().add(koreaTimeZoneOffset);
  }

  String formatNotificationTime(DateTime time) {
    final now = convertToKST(DateTime.now()); // 실시간 대한민국 시간
    final difference = now.difference(time);

    print("현재시간:$now 받은 시간:$time 차이는: $difference");

    if (difference.inDays >= 1) {
      return DateFormat('MM월 dd일').format(time);
    } else if (difference.inHours >= 1) {
      return '${difference.inHours}시간 전';
    } else {
      return '${difference.inMinutes}분 전';
    }
  }

  @override
  Widget build(BuildContext context) {
    // 메시지 리스트를 시간 순으로 정렬
    widget.messages.sort((a, b) {
      DateTime timeA = a['time'];
      DateTime timeB = b['time'];
      return timeB.compareTo(timeA); // 내림차순 정렬
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "홈",
          style: TextStyle(
            fontFamily: 'LGText',
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold, // 글자를 볼드로 설정
          ),
        ),

        titleSpacing: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/FTIE_엘지배경_대지.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 90),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 16.0, bottom: 10.0), // bottom padding 추가
              child: Container(
                width: double.infinity,
                child: Text(
                  '알림',
                  style: TextStyle(
                    fontFamily: 'LGText',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                if (widget.messages.isNotEmpty)
                  ...widget.messages.map((message) {
                    return Stack(
                      children: [
                        Card(
                          elevation: 0,
                          margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.white,
                          child: ListTile(
                            contentPadding: EdgeInsets.only(
                              top:12.0,
                              // bottom: 8.0,
                              left: 20.0,
                              right: 20.0,
                            ),
                            title: Text(
                              message['content'],
                              style: TextStyle(fontSize: 15),
                            ),
                            trailing: Text(
                              formatNotificationTime(message['time']),
                              style: TextStyle(fontFamily: 'LGText',fontSize: 12, color: Colors.grey),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10, // 카드의 상단에서 간격 조정
                          left: 40, // 카드의 왼쪽에서 간격 조정
                          child: Text(
                            "푸디온",
                            style: TextStyle(
                              fontFamily: 'LGText',
                              fontSize: 13,
                              color: Colors.black.withOpacity(0.5), // 희미하게 표시
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList()
                else
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        children: [
                          SizedBox(height: 250.0),
                          Text(
                            '현재 알림이 없습니다.',
                            style: TextStyle(
                              fontFamily: 'LGText',
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}