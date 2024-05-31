import 'dart:math';

import 'package:flutter/material.dart';

// Custom Progress Indicator Widget
class AnimatedCircularProgressIndicator extends StatefulWidget {
  final double progress;
  final double size;

  const AnimatedCircularProgressIndicator({
    required this.progress,
    super.key,
    this.size = 200.0,
  });

  @override
  State<AnimatedCircularProgressIndicator> createState() => _AnimatedCircularProgressIndicatorState();
}

class _AnimatedCircularProgressIndicatorState extends State<AnimatedCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..addListener(() {
        setState(() {});
      });
    _animation = Tween<double>(begin: 0, end: widget.progress).animate(_controller!);

    _controller!.forward();
  }

  @override
  void didUpdateWidget(AnimatedCircularProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _animation = Tween<double>(begin: oldWidget.progress, end: widget.progress).animate(_controller!);
      _controller!
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _CircularProgressPainter(progress: _animation!.value),
        ),
      ),
    );
  }
}

// Custom Painter for the Progress Indicator
class _CircularProgressPainter extends CustomPainter {
  final double progress;

  _CircularProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    Paint progressPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.blue, Colors.blueAccent, Colors.lightBlueAccent],
      ).createShader(Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2))
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, backgroundPaint);
    double sweepAngle = 2 * pi * progress;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
