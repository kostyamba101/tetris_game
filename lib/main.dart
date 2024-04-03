import 'package:flutter/material.dart';
import 'package:tetris_game/board.dart';
import 'package:tetris_game/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const GameBoard(),
          '/settings': (context) => const Settings(),
        });
  }
}
