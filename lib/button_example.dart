import 'package:flutter/material.dart';
import 'package:flutter_animation/button.dart';

class ButtonExample extends StatelessWidget {
  const ButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: IntrinsicHeight(
          child: Button(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            onTap: () {},
            child: const Text('Button', style: TextStyle(fontSize: 48)),
          ),
        ),
      ),
    );
  }
}
