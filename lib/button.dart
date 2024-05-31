import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  const Button({
    required this.child,
    required this.onTap,
    this.padding,
    this.radius = 18,
    super.key,
  });
  final Widget child;
  final VoidCallback onTap;
  final EdgeInsets? padding;
  final double radius;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    widget.onTap();
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: IntrinsicWidth(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: widget.padding,
          transform: Matrix4.translationValues(0, _isPressed ? 20 : 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            color: const Color(0xFFF0F5FF),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, _isPressed ? 8 : 28),
                blurRadius: 0,
              ),
            ],
          ),
          child: Center(
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
