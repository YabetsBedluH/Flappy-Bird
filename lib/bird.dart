import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  const Bird({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60, width: 60, child: Image.asset('lib/images/Flappybird.png'));
  }
}
