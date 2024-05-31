import 'package:flutter/material.dart';

class TinderSelect extends StatefulWidget {
  const TinderSelect({super.key});

  @override
  State<TinderSelect> createState() => _TinderSelectState();
}

class _TinderSelectState extends State<TinderSelect> {
  Offset _startDragOffset = Offset.zero;
  Offset _currentOffset = Offset.zero;
  bool _isDragging = false;

  void _onPanStart(DragStartDetails details) {
    _startDragOffset = details.localPosition;
    setState(() {
      _isDragging = true;
      _currentOffset = Offset.zero;
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _currentOffset = details.localPosition - _startDragOffset;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
      _currentOffset = Offset.zero;
    });
  }

  bool _isSelected() {
    return _currentOffset.dx != 0 && _currentOffset.dx > 150;
  }

  bool _isRejected() {
    return _currentOffset.dx < -150;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final offset = _isDragging ? _currentOffset : Offset.zero;
    final rotation = offset.dx / screenWidth / 2; // Rotate based on swipe direction
    final colorValue = (offset.dx.abs() / screenWidth * 2).clamp(0.0, 1.0);
    final color = offset.dx < 0
        ? Color.lerp(Colors.blue, Colors.red, colorValue)
        : Color.lerp(Colors.blue, Colors.green, colorValue);
    var displayOk = '';
    if (_isSelected()) {
      displayOk = 'YES';
    } else if (_isRejected()) {
      displayOk = 'NO';
    }

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GestureDetector(
          onPanStart: _onPanStart,
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onPanEnd,
          child: Transform.translate(
            offset: _currentOffset,
            child: Transform.rotate(
              angle: rotation,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    displayOk,
                    style: const TextStyle(fontSize: 32, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
