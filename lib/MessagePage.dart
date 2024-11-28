import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessagePage extends StatefulWidget {
  final List<Map<String, dynamic>> messages;

  MessagePage({required this.messages});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  String shelfLocation = "선반 1";

  String formatNotificationTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

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
          shelfLocation,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
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
                    return Card(
                      elevation: 0,
                      margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.white,
                      child: ListTile(
                        title: Text(
                          message['content'],
                          style: TextStyle(fontSize: 15),
                        ),
                        trailing: Text(
                          formatNotificationTime(message['time']),
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
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
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
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