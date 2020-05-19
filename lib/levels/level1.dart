import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart' show Colors;

import '../components/level.dart';
import '../components/platform.dart';
import '../game.dart';
import '../components/text.dart';


Level level1(MonumentPlatformer game) {
  return Level.create(
    game: game,
    foreground: [
      // Text.create(
      //   game: game,
      //   text: 'eee',
      //   style: TextStyle(
      //     color: Colors.black,
      //     fontFamily: "Fira Code",
      //   ),
      //   pos: Offset(100, 10),
      //   align: TextAlign.left
      // ),
      Platform.create(
        game: game,
        color: Color(0xff333333),
        initialPosition: Offset(-500, 30),
        size: Offset(1000, 20),
      ),
      Platform.create(
        game: game,
        color: Color(0xff333333),
        initialPosition: Offset(100, -10),
        size: Offset(100, 40),
      ),
      Platform.create(
        game: game,
        color: Color(0xff333333),
        initialPosition: Offset(400, -100),
        size: Offset(100, 150),
      ),
    ],
  );
}
