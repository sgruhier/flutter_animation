import 'package:flutter/material.dart';
import 'package:flutter_animation/builtin_animation.dart';
import 'package:flutter_animation/button_example.dart';
import 'package:flutter_animation/custom_paint.dart';
import 'package:flutter_animation/custom_paint_example1.dart';
import 'package:flutter_animation/explicit_animation.dart';
import 'package:flutter_animation/explicit_animation_demo.dart';
import 'package:flutter_animation/plain_button.dart';
import 'package:flutter_animation/tinder_select.dart';
import 'package:flutter_animation/tinder_select_animated.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BuiltinAnimation()));
              },
              child: const Text('Built in animation'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AnimatedContainerWidget()));
              },
              child: const Text('Explicit animation'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const StaggeredAnimation()));
              },
              child: const Text('Explicit animation #2'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ButtonExample()));
              },
              child: const Text('Button'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PlainButton(
                      child: Text(
                        'Plain Button',
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                  ),
                );
              },
              child: const Text('Plain Button'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CustomPaintExample1()));
              },
              child: const Text('Custom paint #1'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AnimatedCircularProgressIndicator(progress: 0.75)));
              },
              child: const Text('Custom paint - Animation'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TinderSelect()));
              },
              child: const Text('Tinder step 1'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TinderAnimatedSelect()));
              },
              child: const Text('Tinder step 2'),
            ),
          ],
        ),
      ),
    );
  }
}
