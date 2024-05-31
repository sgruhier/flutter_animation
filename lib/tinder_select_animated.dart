import 'package:flutter/material.dart';

class TinderAnimatedSelect extends StatefulWidget {
  const TinderAnimatedSelect({super.key});

  @override
  State<TinderAnimatedSelect> createState() => _TinderAnimatedSelectState();
}

class _TinderAnimatedSelectState extends State<TinderAnimatedSelect> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<Offset>? _animation;

  Offset _startDragOffset = Offset.zero;
  Offset _currentOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _controller.addListener(() {
      setState(() {
        _currentOffset = _animation!.value;
      });
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _animation = null;
          _currentOffset = Offset.zero;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    _startDragOffset = details.localPosition;
    setState(() {
      _currentOffset = Offset.zero;
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _currentOffset = details.localPosition - _startDragOffset;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final size = MediaQuery.of(context).size;
    if (_isSelected()) {
      _animation = Tween(
        begin: _currentOffset,
        end: Offset(size.width, _currentOffset.dy),
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.elasticOut,
        ),
      );
    } else if (_isRejected()) {
      _animation = Tween(
        begin: _currentOffset,
        end: Offset(-size.width, _currentOffset.dy),
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.elasticOut,
        ),
      );
    }
    // Back to initial position
    else {
      _animation = Tween(
        begin: _currentOffset,
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.elasticOut,
        ),
      );
    }
    _controller.reset();
    _controller.forward();
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
    final rotation = _currentOffset.dx / screenWidth * 0.5; // Rotate based on swipe direction
    final colorValue = (_currentOffset.dx.abs() / screenWidth * 2).clamp(0.0, 1.0);
    final color = _currentOffset.dx < 0
        ? Color.lerp(Colors.blue, Colors.red, colorValue) ?? Colors.red
        : Color.lerp(Colors.blue, Colors.green, colorValue) ?? Colors.blue;
    var displayOk = '';
    if (_isSelected()) {
      displayOk = 'YES';
    } else if (_isRejected()) {
      displayOk = 'NO';
    }
    _currentOffset = _animation != null ? _animation!.value : _currentOffset;

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
            )),
      ),
    );
  }
}
