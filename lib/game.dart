import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    double screenWidth = MediaQuery.of(context).size.width;
    int beg = 44;
    double screenHeight = MediaQuery.of(context).size.height;
    int numberOfRows = (screenHeight > 388 && screenWidth < 850)
        ? (screenHeight ~/ 20) - 2
        : screenHeight ~/ 20 - 1;
    // int numberOfRows= screenHeight ~/ 20;
    int numberOfColumns = screenWidth ~/ 20;
    int numberOfSquares = numberOfColumns * numberOfRows;
    var snakePosition = [
      beg,
      beg + numberOfColumns,
      beg + (numberOfColumns * 2),
      beg + (numberOfColumns * 3),
      beg + (numberOfColumns * 4)
    ];
    print(
        "$screenWidth $screenHeight $numberOfRows $numberOfColumns $numberOfSquares");

    var randomNumber = Random();
    int food = randomNumber.nextInt(numberOfSquares);

    void generateFood() {
      food = randomNumber.nextInt(numberOfSquares);
      if (snakePosition.contains(food)) {
        food = randomNumber.nextInt(numberOfSquares);
      }
    }

    void updateSnake() {}
    void startGame() {
      snakePosition = [
        beg,
        beg + numberOfColumns,
        beg + (numberOfColumns * 2),
        beg + (numberOfColumns * 3),
        beg + (numberOfColumns * 4)
      ];
      print("Hey There");
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
                          crossAxisCount: numberOfColumns),
                      itemBuilder: (BuildContext context, int index) {
                        if (index < numberOfSquares) {
                          if (snakePosition.contains(index)) {
                            print(index);
                            return Center(
                              child: Container(
                                width: 20,
                                height: 20,
                                padding: EdgeInsets.all(2),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          } else if (index == food) {
                            return Container(
                              padding: EdgeInsets.all(2),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  color: Colors.green,
                                ),
                              ),
                            );
                          } else {
                            return Center(
                              child: Container(
                                width: 20,
                                height: 20,
                                padding: EdgeInsets.all(2),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    color: Colors.white38,
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
