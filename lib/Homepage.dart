import 'dart:async';

import 'package:flappybird/bird.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialheight = birdYaxis;
  bool gameHasStarted = false;

  void jump() {
    setState(() {
      time = 0;
      initialheight = birdYaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialheight - height;
      });
      if (birdYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                if (gameHasStarted) {
                  jump();
                } else {
                  startGame();
                }
              },
              child: AnimatedContainer(
                alignment: Alignment(0, birdYaxis),
                duration: const Duration(milliseconds: 0),
                color: Colors.blue,
                child: Bird(),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }
}
