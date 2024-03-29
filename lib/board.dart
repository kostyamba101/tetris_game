import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris_game/piece.dart';
import 'package:tetris_game/pixel.dart';
import 'package:tetris_game/values.dart';

/*

Game Board 

this is a 2x2 grid with null represents an empty space
a non empty space will have the color to represent the landed pieces

*/

//create game board
List<List<Tetriomino?>> gameboard = List.generate(
  columnLength,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
);

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
    Duration frameRate = const Duration(milliseconds: 500);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(
      frameRate,
      (timer) {
        setState(() {
          //check landing
          checkLanding();

          //move current piece down
          currentPiece.movePiece(Direction.down);
        });
      },
    );
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

      //check if the current position is already occupied by another piece in the gameboard
      if (row >= 0 && col >= 0) {
        if (gameboard[row][col] != null) {
          return true;
        }
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
        if (row >= 0 && col >= 0) {
          gameboard[row][col] = currentPiece.type;
        }
      }
      //once landed, create new piece
      createNewPiece();
    }
  }

  void createNewPiece() {
    //create a random object to generate random tetromino types

    Random random = Random();

    // create a new piece with a random type
    Tetriomino randomType =
        Tetriomino.values[random.nextInt(Tetriomino.values.length)];

    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();
  }

  void moveLeft() {
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  void moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //GAME GRID
          Expanded(
            child: GridView.builder(
              itemCount: rowLength * columnLength,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowLength),
              itemBuilder: (context, index) {
                //get row and column of each index
                int row = (index / rowLength).floor();
                int col = index % rowLength;

                //current piece
                if (currentPiece.positions.contains(index)) {
                  return Pixel(
                    color: currentPiece.color,
                    child: index,
                  );
                }
                //landed pieces
                else if (gameboard[row][col] != null) {
                  final Tetriomino? tetriominoType = gameboard[row][col];
                  return Pixel(
                    color: tetriominoColors[tetriominoType],
                    child: '',
                  );
                }

                // blank pixel
                else {
                  return Pixel(
                    color: Colors.grey[900],
                    child: index,
                  );
                }
              },
            ),
          ),

          // GAME CONTROLS
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //left
                IconButton(
                  onPressed: moveLeft,
                  icon: Icon(Icons.arrow_back_ios_new),
                  color: Colors.white,
                ),
                //rotate
                IconButton(
                  onPressed: rotatePiece,
                  icon: Icon(Icons.rotate_right),
                  color: Colors.white,
                ),
                //right
                IconButton(
                  onPressed: moveRight,
                  icon: Icon(Icons.arrow_forward_ios),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
