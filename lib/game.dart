import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  int getAll(BuildContext context) {
    return 0;
  }

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
  int food = 2;

  void generateFood() {
    food = randomNumber.nextInt(numberOfSquares);
    if (snakePosition.contains(food)) {
      food = randomNumber.nextInt(numberOfSquares);
    }
  }

  var direction = 'left';
  void updateSnake() {
    setState(() {
      switch (direction) {
        case 'down':
          print(snakePosition);
          if (snakePosition.last > (numberOfRows - 1) * numberOfColumns) {
            print("hey");
            snakePosition.add(snakePosition.last +
                (numberOfColumns as int) -
                (numberOfSquares as int));
          } else {
            snakePosition.add(snakePosition.last + (numberOfColumns as int));
            print("hi");
          }
          // snakePosition.removeAt(0);
          break;

        case 'up':
          print(snakePosition);
          if (snakePosition.last < numberOfColumns) {
            snakePosition.add(snakePosition.last -
                (numberOfColumns as int) +
                (numberOfSquares as int));
          } else {
            snakePosition.add(snakePosition.last - (numberOfColumns as int));
          }

          break;

        case 'left':
          print(snakePosition);
          if (snakePosition.last % (numberOfColumns as int) == 0) {
            snakePosition
                .add(snakePosition.last - 1 + (numberOfColumns as int));
          } else {
            snakePosition.add(snakePosition.last - 1);
          }
          // snakePosition.removeAt(0);

          break;

        // case 'right':
        //   print(snakePosition);
        //   if (((snakePosition.last + 1 )% numberOfColumns == 0)) {
        //     snakePosition
        //         .add(snakePosition.last + 1 - (numberOfColumns as int));
        //   } else {
        //     snakePosition.add(snakePosition.last + 1);
        //   }
        //   break;

        case 'right':
          print(snakePosition);
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
    print("Hey There");
    const duration = const Duration(milliseconds: 1000);
    Timer.periodic(duration, (timer) {
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
                            // print(index);
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
              padding: EdgeInsets.only(bottom: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      startGame();
                    },
                    child: const Padding(
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
