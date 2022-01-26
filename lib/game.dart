import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  var snakePosition = [20, 21, 22, 23, 24];
  int beg = 44;
  get isLandscape =>
      MediaQuery.of(context).orientation == Orientation.landscape;
  get screenWidth => MediaQuery.of(context).size.width;
  get screenHeight => MediaQuery.of(context).size.height;

  get numberOfRows => (screenHeight > 388 && screenWidth < 850)
      ? (screenHeight ~/ 20) - 2
      : screenHeight ~/ 20 - 1;
  get numberOfColumns => screenWidth ~/ 20;
  get numberOfSquares => numberOfColumns * numberOfRows;

  // List<num> get snakePosition => [
  //       beg,
  //       beg + numberOfColumns,
  //       beg + (numberOfColumns * 2),
  //       beg + (numberOfColumns * 3),
  //       beg + (numberOfColumns * 4),
  //       // print("dhee"),
  //     ];

  var randomNumber = Random();
  int food = 29;

  void generateFood() {
    food = randomNumber.nextInt(numberOfSquares);
    if (snakePosition.contains(food)) {
      food = randomNumber.nextInt(numberOfSquares);
    }
  }

  bool isAvail(int x) {
    if (snakePosition.contains(x)) {
      // print(x);
      return true;
    }
    return false;
  }

  var direction = 'left';
  void updateSnake() {
    setState(() {
      switch (direction) {
        case 'down':
          // print(snakePosition);
          if (snakePosition.last > (numberOfRows - 1) * numberOfColumns) {
            //numrow-1*numcol to find if we are in the second last row
            // print("hey");

            snakePosition.add(snakePosition.last +
                (numberOfColumns as int) -
                (numberOfSquares
                    as int)); //if yes the we take a full turn and come down from the top
          } else {
            snakePosition.add(snakePosition.last +
                (numberOfColumns
                    as int)); //else go on to next row by adding the number of colums to current position
            // print("hi");
          }
          // snakePosition.removeAt(0);
          break;

        case 'up':
          // print(numberOfSquares);
          // print(snakePosition);
          if (snakePosition.last < numberOfColumns) {
            snakePosition.add(snakePosition.last -
                (numberOfColumns as int) +
                (numberOfSquares as int));
          } else {
            snakePosition.add(snakePosition.last - (numberOfColumns as int));
          }

          break;

        case 'left':
          // print(snakePosition);
          if (snakePosition.last % (numberOfColumns as int) == 0) {
            // print(snakePosition.last % (numberOfColumns as int));
            snakePosition
                .add(snakePosition.last - 1 + (numberOfColumns as int));
            // print(snakePosition.last - 1 + (numberOfColumns as int));
          } else if (isAvail(snakePosition.last - 1)) {
            snakePosition = List.from(snakePosition.reversed);
            snakePosition.add(snakePosition.last - 1);

            // snakePosition.add(snakePosition.last - (snakePosition.length - 1));
          } else {
            snakePosition.add(snakePosition.last - 1);
          }

          break;

        case 'right':
          // print(snakePosition);
          if (((snakePosition.last + 1) % (numberOfColumns as int) == 0)) {
            snakePosition
                .add(snakePosition.last + 1 - (numberOfColumns as int));
          } else {
            snakePosition.add(snakePosition.last + 1);
          }
          break;

        default:
      }

      if (snakePosition.last == food) {
        generateFood();
      } else {
        snakePosition.removeAt(0);
      }
    });
  }

  void startGame() {
    // snakePosition = [
    //   beg,
    //   beg + numberOfColumns,
    //   beg + (numberOfColumns * 2),
    //   beg + (numberOfColumns * 3),
    //   beg + (numberOfColumns * 4)
    // ];

    snakePosition = [20, 21, 22, 23, 24];
    // print("Hey There");
    const duration = Duration(milliseconds: 200);
    Timer.periodic(duration, (timer) {
      if (gameOver()) {
        timer.cancel();
        showGameOverScreen();
      }
      updateSnake();
    });
  }

  @override
  Widget build(BuildContext context) {
    // int numberOfRows= screenHeight ~/ 20;

    // print(
    //     "$screenWidth $screenHeight $numberOfRows $numberOfColumns $numberOfSquares");

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (direction != 'up' && details.delta.dy > 0) {
                    // print("njaaan");
                    direction = 'down';
                  } else if (direction != 'down' && details.delta.dy < 0) {
                    direction = 'up';
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (direction != 'left' && details.delta.dx > 0) {
                    direction = 'right';
                  } else if (direction != 'right' && details.delta.dx < 0) {
                    direction = 'left';
                  }
                },
                child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: numberOfColumns),
                    itemBuilder: (BuildContext context, int index) {
                      if (index < numberOfSquares) {
                        if (snakePosition.contains(index)) {
                          // print(index);
                          return Center(
                            child: Container(
                              width: 20,
                              height: 20,
                              padding: const EdgeInsets.all(2),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        } else if (index == food) {
                          return Container(
                            padding: const EdgeInsets.all(2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
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
                              padding: const EdgeInsets.all(2),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  color: Colors.transparent,
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
            Padding(
              padding: const EdgeInsets.only(bottom: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      startGame();
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(8.0, 8, 8, 8),
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

  bool gameOver() {
    for (int i = 0; i < snakePosition.length; i++) {
      int count = 0;
      for (int j = 0; j < snakePosition.length; j++) {
        if (snakePosition[i] == snakePosition[j]) {
          count += 1;
        }

        if (count == 2) {
          return true;
        }
      }
    }
    return false;
  }

  void showGameOverScreen() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("GAME OVER"),
            content: Text("Your Score: " + snakePosition.length.toString()),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    startGame();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Play Again"))
            ],
          );
        });
  }
}
