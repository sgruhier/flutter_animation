import 'package:flutter/material.dart';

class BuiltinAnimation extends StatefulWidget {
  const BuiltinAnimation({super.key});

  @override
  State<BuiltinAnimation> createState() => _BuiltinAnimationState();
}

class _BuiltinAnimationState extends State<BuiltinAnimation> {
  bool _toggled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: _toggled ? 200 : 100,
          height: _toggled ? 200 : 100,
          decoration: BoxDecoration(
            color: _toggled ? Colors.blue : Colors.red,
            borderRadius: BorderRadius.circular(_toggled ? 20 : 0),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _toggled = !_toggled;
          });
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
