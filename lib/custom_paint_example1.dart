import 'package:flutter/material.dart';

class CustomPaintExample1 extends StatelessWidget {
  const CustomPaintExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CustomPaint Example')),
      body: Center(
        child: CustomPaint(
          size: const Size(200, 200),
          painter: SolidColorPainter(),
        ),
      ),
    );
  }
}

class SolidColorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
