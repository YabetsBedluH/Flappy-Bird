import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  const MyBarrier({super.key, this.size});

  final size;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: size,
        decoration: BoxDecoration(
          color: Colors.green,
        ));
  }
}
