import 'dart:async';

import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  static List<int> snakePosition = [45, 65, 85, 105, 125];
  @override
  Widget build(BuildContext context) {
    int numberOfSquares = 720;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    void updateSnake() {}
    void startGame() {
      snakePosition = [45, 65, 85, 105, 125];
      const duration = const Duration(milliseconds: 300);
      Timer.periodic(duration, (timer) {
        updateSnake();
      });
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: GestureDetector(
                child: Container(
                  // height: screenHeight * 0.5,
                  child: GridView.builder(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 20),
                      itemBuilder: (BuildContext context, int index) {
                        if (index < numberOfSquares) {
                          if (snakePosition.contains(index)) {
                            return Center(
                              child: Container(
                                padding: EdgeInsets.all(2),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Center(
                              child: Container(
                                padding: EdgeInsets.all(2),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    color: Colors.white12,
                                  ),
                                ),
                              ),
                            );
                          }
                        } else {
                          return Container();
                        }
                      }),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      startGame();
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 8),
                      child: Text(
                        "START",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
