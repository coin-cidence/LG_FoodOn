import 'package:flutter/material.dart';

class InfoDialog extends StatelessWidget {
  final double xPosition; // X-axis position of the info icon
  final double yPosition; // Y-axis position of the info icon

  InfoDialog({required this.xPosition, required this.yPosition});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: yPosition + 10, // Place just below the icon
      left: xPosition - (200 / 2), // Center the dialog below the icon
      child: CustomPaint(
        painter: BalloonPainter(color: Colors.white),
        child: Container(
          width: 300,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "식품이 미등록된 상태예요.",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "식품이 등록된 상태예요.\n(장기 미사용 등록일이 지나면 보라색으로 변경돼요.)",
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.purple[200],
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "식품이 장기간 미사용 상태예요.",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.orange[300],
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "식품을 잠시 꺼낸 상태예요.\n(24시간 동안 식품을 다시 올리지 않으면 초기화돼요.)",
                      softWrap: true,
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

    final shadowPaint = Paint()
      ..color = Colors.black26
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4);

    final path = Path()
      ..moveTo(10, 0) // Top-left corner
      ..lineTo(size.width - 10, 0) // Top-right corner
      ..arcToPoint(Offset(size.width, 10), radius: Radius.circular(10))
      ..lineTo(size.width, size.height - 20) // Right side
      ..arcToPoint(Offset(size.width - 10, size.height), radius: Radius.circular(10))
      ..lineTo(size.width / 2 + 10, size.height) // Balloon triangle right edge
      ..lineTo(size.width / 2, size.height + 10) // Balloon triangle tip
      ..lineTo(size.width / 2 - 10, size.height) // Balloon triangle left edge
      ..lineTo(10, size.height) // Left side
      ..arcToPoint(Offset(0, size.height - 10), radius: Radius.circular(10))
      ..lineTo(0, 10) // Back to top-left corner
      ..arcToPoint(Offset(10, 0), radius: Radius.circular(10))
      ..close();

    final shadowPath = Path.from(path)..shift(Offset(0, 4));
    canvas.drawPath(shadowPath, shadowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
