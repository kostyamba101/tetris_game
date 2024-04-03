import 'package:flutter/material.dart';

int rowLength = 10;
int columnLength = 15;
double speed = 300;

enum Direction { left, right, down }

enum Tetriomino {
  L,
  J,
  I,
  O,
  S,
  Z,
  T,
}

/* 
0
0
0 0

  0
  0
0 0

0
0
0
0

0 0
0 0

  0 0
0 0

0 0
  0 0

0
0 0
0

*/

const Map<Tetriomino, Color> tetriominoColors = {
  Tetriomino.L: Colors.orange,
  Tetriomino.J: Colors.blue,
  Tetriomino.I: Colors.pink,
  Tetriomino.O: Colors.yellow,
  Tetriomino.S: Colors.green,
  Tetriomino.Z: Colors.red,
  Tetriomino.T: Colors.purple,
};
