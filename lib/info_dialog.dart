import 'package:flutter/material.dart';

class InfoDialog extends StatelessWidget {
  final double xPosition; // X-axis position of the info icon
  final double yPosition; // Y-axis position of the info icon

  InfoDialog({required this.xPosition, required this.yPosition});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: yPosition, // Place just below the icon
      left: xPosition - (280 / 2), // Center the dialog below the icon
      child: CustomPaint(
        painter: BalloonPainter(color: Colors.white),
        child: Container(
          width: 330,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "식품이 미등록된 상태예요.\n",
                            style: TextStyle(color: Colors.black, fontSize: 14), // 기본 텍스트 스타일
                          ),
                          TextSpan(
                            text: " (식품을 올리면 색이 변해요!)",
                            style: TextStyle(color: Color(0xFFA9A9A9), fontSize: 12), // 추가 텍스트 스타일
                          ),
                        ]
                      ),
                    ),
                  ),
                ]
              ),
              SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                              text: "식품이 등록된 상태예요.\n",
                              style: TextStyle(color: Colors.black, fontSize: 14), // 기본 텍스트 스타일
                            ),
                            TextSpan(
                              text: "(장기 미사용 등록일이 지나면 보라색으로 변경돼요.)",
                              style: TextStyle(color: Color(0xFFA9A9A9), fontSize: 12), // 추가 텍스트 스타일
                            ),
                          ]
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.purple[200],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                              text: "식품이 장기간 미사용 상태예요.\n",
                              style: TextStyle(color: Colors.black, fontSize: 14), // 기본 텍스트 스타일
                            ),
                            TextSpan(
                              text: "(장기 미사용 등록을 하면 관리가 편해요!)",
                              style: TextStyle(color: Color(0xFFA9A9A9), fontSize: 12), // 추가 텍스트 스타일
                            ),
                          ]
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.orange[300],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                              text: "식품을 잠시 꺼낸 상태예요.\n",
                              style: TextStyle(color: Colors.black, fontSize: 14), // 기본 텍스트 스타일
                            ),
                            TextSpan(
                              text: "(24시간 동안 식품을 다시 올리지 않으면 초기화돼요.)",
                              style: TextStyle(color: Color(0xFFA9A9A9), fontSize: 12), // 추가 텍스트 스타일
                            ),
                          ]
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BalloonPainter extends CustomPainter {
  final Color color;

  BalloonPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // 그림자 페인트
    final shadowPaint = Paint()
      ..color = Colors.black26
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4);

    final path = Path()
      ..moveTo(10, 0) // 좌측 상단에서 시작
      ..lineTo(size.width - 35, 0) // 삼각형 왼쪽 시작점
      ..lineTo(size.width - 25, -10) // 삼각형 꼭짓점
      ..lineTo(size.width - 15, 0) // 삼각형 오른쪽 끝점
      ..lineTo(size.width - 10, size.height - 10) // 우측 하단 직선
      ..arcToPoint(
        Offset(size.width - 20, size.height),
        radius: Radius.circular(10),
        clockwise: true,
      ) // 우측 하단 둥근 모서리
      ..lineTo(20, size.height) // 좌측 하단 직선
      ..arcToPoint(
        Offset(10, size.height - 10),
        radius: Radius.circular(10),
        clockwise: true,
      ) // 좌측 하단 둥근 모서리
      ..lineTo(10, 10) // 좌측 상단 직선
      ..arcToPoint(
        Offset(20, 0),
        radius: Radius.circular(10),
        clockwise: true,
      ) // 좌측 상단 둥근 모서리
      ..close();

    // 그림자 경로 설정
    final shadowPath = Path.from(path)..shift(Offset(2, 2));

    // 그림자 경로 확장
    final expandedShadowPath = Path.combine(
      PathOperation.union,
      shadowPath,
      Path()
        ..addRect(Rect.fromLTRB(
            shadowPath.getBounds().left - 8,  // 좌측 확장
            shadowPath.getBounds().top + 14,   // 상단 확장
            shadowPath.getBounds().right + 8, // 우측 확장
            shadowPath.getBounds().bottom - 2 // 하단 확장
        )),
    );

    // 그림자와 본체 그리기
    canvas.drawPath(expandedShadowPath, shadowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}