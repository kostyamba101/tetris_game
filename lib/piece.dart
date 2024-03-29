import 'package:tetris_game/values.dart';

class Piece {
  //type of tetris piece
  Tetriomino type;

  Piece({required this.type});

  // the piece is just a list of integers
  List<int> positions = [];

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
}
