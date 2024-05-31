import 'package:flutter/material.dart';

class PlainButton extends StatefulWidget {
  const PlainButton({
    required this.child,
    this.padding,
    this.radius = 18,
    super.key,
  });
  final Widget child;
  final EdgeInsets? padding;
  final double radius;

  @override
  State<PlainButton> createState() => _PlainButtonState();
}

class _PlainButtonState extends State<PlainButton> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: GestureDetector(
              onTapDown: (_) {
                setState(() {
                  _isPressed = true;
                });
              },
              onTapUp: (_) {
                setState(() {
                  _isPressed = false;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: 300,
                height: 100,
                padding: widget.padding,
                transform: Matrix4.translationValues(0, _isPressed ? 10 : 0, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.radius),
                  color: const Color(0xFFF0F5FF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, _isPressed ? 4 : 20),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: Center(
                  child: widget.child,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (_isPressed)
            const Text(
              'here',
              style: TextStyle(fontSize: 48),
            ),
        ],
      ),
    );
  }
}
