import 'package:flutter/material.dart';
import 'package:tetris_game/board.dart';
import 'package:tetris_game/values.dart';

class Piece {
  //type of tetris piece
  Tetriomino type;

  Piece({required this.type});

  // the piece is just a list of integers
  List<int> positions = [];

  //color of the tetris piece
  Color get color {
    return tetriominoColors[type] ?? Colors.white;
  }

  // generate the integers

  void initializePiece() {
    switch (type) {
      case Tetriomino.L:
        positions = [
          -26,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetriomino.J:
        positions = [
          -25,
          -15,
          -5,
          -6,
        ];
        break;
      case Tetriomino.I:
        positions = [
          -4,
          -5,
          -6,
          -7,
        ];
        break;
      case Tetriomino.O:
        positions = [
          -15,
          -16,
          -5,
          -6,
        ];
        break;
      case Tetriomino.S:
        positions = [
          -15,
          -14,
          -6,
          -5,
        ];
        break;
      case Tetriomino.Z:
        positions = [
          -17,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetriomino.T:
        positions = [
          -26,
          -16,
          -6,
          -15,
        ];
        break;

      default:
    }
  }

  //move piece
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < positions.length; i++) {
          positions[i] += rowLength;
        }
        break;
      case Direction.left:
        for (int i = 0; i < positions.length; i++) {
          positions[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < positions.length; i++) {
          positions[i] += 1;
        }
        break;

      default:
    }
  }

  int rotationState = 1;
  void rotatePiece() {
    //new position
    List<int> newPositions = [];

    switch (type) {
      case Tetriomino.L:
        switch (rotationState) {
          case 0:
            /*
            0
            0
            0 0 

          */
            newPositions = [
              positions[1] - rowLength,
              positions[1],
              positions[1] + rowLength,
              positions[1] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;

              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 1:
            /*
            0 0 0 
            0
            
          */
            newPositions = [
              positions[1] - 1,
              positions[1],
              positions[1] + 1,
              positions[1] + rowLength - 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;

              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            /*

            0 0 
              0 
              0

            */
            newPositions = [
              positions[1] + rowLength,
              positions[1],
              positions[1] - rowLength,
              positions[1] - rowLength - 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;

              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*
          
                0 
            0 0 0

            */
            newPositions = [
              positions[1] - rowLength + 1,
              positions[1],
              positions[1] + 1,
              positions[1] - 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;

              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
      case Tetriomino.J:
        switch (rotationState) {
          case 0:
            /*
              0
              0
            0 0 

          */
            newPositions = [
              positions[1] - rowLength,
              positions[1],
              positions[1] + rowLength,
              positions[1] + rowLength - 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;

              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 1:
            /*
            
            0
            0 0 0 
            
          */
            newPositions = [
              positions[1] - rowLength - 1,
              positions[1],
              positions[1] - 1,
              positions[1] + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;

              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            /*

            0 0 
            0 
            0

            */
            newPositions = [
              positions[1] + rowLength,
              positions[1],
              positions[1] - rowLength,
              positions[1] - rowLength + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;

              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*
          
            0 0 0 
                0

            */
            newPositions = [
              positions[1] + 1,
              positions[1],
              positions[1] - 1,
              positions[1] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;

              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
      case Tetriomino.I:
        switch (rotationState) {
          case 0:
            /*
              0 0 0 0            

          */
            newPositions = [
              positions[1] - 1,
              positions[1],
              positions[1] + 1,
              positions[1] + 2,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;

              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 1:
            /*
            
            0
            0 
            0
            0 
            
          */
            newPositions = [
              positions[1] - rowLength,
              positions[1],
              positions[1] - rowLength,
              positions[1] + 2 * rowLength,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;

              rotationState = (rotationState + 1) % 4;
            }
            break;
        }

      case Tetriomino.O:
        switch (rotationState) {
          case 0:
            /*
              0 0 
              0 0            

          */
            break;
        }
      case Tetriomino.S:
        switch (rotationState) {
          case 0:
            /*
          
              0 0
            0 0 

          */
            newPositions = [
              positions[1],
              positions[1] + 1,
              positions[1] + rowLength - 1,
              positions[1] + rowLength,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;

              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 1:
            /*
            
            0
            0 0 
              0
            
          */
            newPositions = [
              positions[1] - rowLength,
              positions[1],
              positions[1] + 1,
              positions[1] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;

              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
      case Tetriomino.Z:
        switch (rotationState) {
          case 0:
            /*
          
            0 0
              0 0 

          */
            newPositions = [
              positions[0] + rowLength - 2,
              positions[1] + 1,
              positions[2] + rowLength - 1,
              positions[3] + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;

              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 1:
            /*
            
            0
            0 0 
              0
            
          */
            newPositions = [
              positions[0] - rowLength + 2,
              positions[1],
              positions[2] - rowLength + 1,
              positions[3] - 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;

              rotationState = (rotationState + 1) % 4;
            }
            break;
        }

      case Tetriomino.T:
        switch (rotationState) {
          case 0:
            /*
          
            0
            0 0 
            0

          */
            newPositions = [
              positions[2] - rowLength,
              positions[2],
              positions[2] + 1,
              positions[2] + rowLength,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;

              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 1:
            /*
            
            0 0 0
              0
            
          */
            newPositions = [
              positions[1] - 1,
              positions[1],
              positions[1] + 1,
              positions[1] + rowLength,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;

              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*
              0
            0 0 
              0
            
            */
            newPositions = [
              positions[1] - rowLength,
              positions[1] - 1,
              positions[1],
              positions[1] + rowLength,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;

              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*
              0
            0 0 0
                          
            */
            newPositions = [
              positions[1] - rowLength,
              positions[1] - 1,
              positions[1],
              positions[1] + 1,
            ];
            if (piecePositionIsValid(newPositions)) {
              positions = newPositions;

              rotationState = (rotationState + 1) % 4;
            }
            break;
        }

        break;
      default:
    }
  }

  bool positionIsValid(int position) {
    int row = (position / rowLength).floor();
    int col = position % rowLength;

    if (row < 0 || col < 0 || gameboard[row][col] != null) {
      return false;
    } else {
      return true;
    }
  }

  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      if (!positionIsValid(pos)) {
        return false;
      }

      int col = pos % rowLength;
      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == rowLength - 1) {
        lastColOccupied = true;
      }
    }
    return !(firstColOccupied && lastColOccupied);
  }
}
