import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tetris_game/piece.dart';
import 'package:tetris_game/pixel.dart';
import 'package:tetris_game/values.dart';

/*

Game Board 

this is a 2x2 grid with null represents an empty space
a non empty space will have the color to represent the landed pieces

*/

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  //current tetris piece
  Piece currentPiece = Piece(type: Tetriomino.T);

  @override
  void initState() {
    super.initState();

    //start game when app starts
    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();

    //frame refresh rate
    Duration frameRate = const Duration(milliseconds: 800);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        //move current piece down
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  //check for collision in a future position
  //return true if there is a collision
  //return false if there is no collision
  bool checkCollision(Direction direction) {
    //loop through each position of the current piece
    for (int i = 0; i < currentPiece.positions.length; i++) {
      //calculate the row and column of the current position
      int row = (currentPiece.positions[i] / rowLength).floor();
      int col = currentPiece.positions[i] % rowLength;
      //adjust the row and column based on the direction
      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }
      //check if the position is out of bounds (either too low or too far to the left or right)
      if (row >= columnLength || col < 0 || col >= rowLength) {
        return true;
      }
    }
    //if no collision, return false
    return false;
  }

  void checkLanding() {
    //if going down is occupied
    if (checkCollision(Direction.down)) {
      //mark possitions as occupied on the gameboard
      for (int i = 0; i < currentPiece.positions.length; i++) {
        int row = (currentPiece.positions[i] / rowLength).floor();
        int col = currentPiece.positions[i] % rowLength;
        if (row >= 0 && col >= 0) {}
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GridView.builder(
        itemCount: rowLength * columnLength,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: rowLength),
        itemBuilder: (context, index) {
          if (currentPiece.positions.contains(index)) {
            return Pixel(
              color: Colors.yellow,
              child: index,
            );
          } else {
            return Pixel(
              color: Colors.grey[900],
              child: index,
            );
          }
        },
      ),
    );
  }
}
