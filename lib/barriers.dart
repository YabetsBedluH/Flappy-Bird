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
          border: Border.all(
            width: 10,
            color: const Color.fromARGB(255, 33, 118, 36),
          ),
          borderRadius: BorderRadius.circular(15)),
    );
  }
}
