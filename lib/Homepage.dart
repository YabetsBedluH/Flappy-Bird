import 'dart:async';

import 'package:flappybird/barriers.dart';
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
  double initialHeight = birdYaxis;
  bool gameHasStarted = false;
  static double barrierXone = 1;
  int score = 0;
  int bestScore = 0;
  double barrierXtwo = barrierXone + 1.5;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  bool checkCollision() {
    const birdWidth = 0.1;
    const birdHeight = 0.1;
    const barrierWidth = 0.4;
    const gapHeight = 0.4;

    // Check collision with barrier one
    if ((barrierXone - birdWidth <= 0 && barrierXone + barrierWidth >= 0)) {
      if (birdYaxis <= -1 + gapHeight) return true;
      if (birdYaxis >= 1 - gapHeight) return true;
    }

    // Check collision with barrier two
    if ((barrierXtwo - birdWidth <= 0 && barrierXtwo + barrierWidth >= 0)) {
      if (birdYaxis <= -1 + gapHeight) return true;
      if (birdYaxis >= 1 - gapHeight) return true;
    }

    return false;
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;

      setState(() {
        birdYaxis = initialHeight - height;
      });

      // move barriers
      setState(() {
        if (barrierXone < -2) {
          barrierXone += 3.5;
          score++;
        } else {
          barrierXone -= 0.05;
        }

        if (barrierXtwo < -2) {
          barrierXtwo += 3.5;
          score++;
        } else {
          barrierXtwo -= 0.05;
        }
      });

      // check game over
      if (birdYaxis > 1 || checkCollision()) {
        timer.cancel();
        gameHasStarted = false;
        showGameOverDialog();
      }
    });
  }

  void resetGame() {
    setState(() {
      birdYaxis = 0;
      time = 0;
      initialHeight = birdYaxis;
      barrierXone = 1;
      barrierXtwo = barrierXone + 1.5;
      if (score > bestScore) {
        bestScore = score;
      }
      score = 0;
    });
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.brown[300],
          title: const Text(
            "Game Over",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Try again?",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                resetGame();
              },
              child: const Text(
                "Play Again",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdYaxis),
                    duration: const Duration(milliseconds: 0),
                    color: Colors.blue,
                    child: const Bird(),
                  ),
                  Container(
                    alignment: const Alignment(0, -0.3),
                    child: gameHasStarted
                        ? const SizedBox()
                        : const Text(
                            "T A P  T O  P L A Y",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const MyBarrier(size: 200.0),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, -1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const MyBarrier(size: 200.0),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const MyBarrier(size: 150.0),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, -1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const MyBarrier(size: 250.0),
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "SCORE",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "$score",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 35),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "BEST",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "$bestScore",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 35),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
