import 'dart:ui';

import 'package:flutter/painting.dart';

import '../../game.dart';
import '../background.dart';
import '../level.dart';
import '../platform.dart';

Level level1(MonumentPlatformer game) {
  return Level.create(
    game: game,
    layers: {
      Layers.background: [
        Background.create(
          game: game,
          initialColor: Color(0xffffffff),
        ),
      ],
      Layers.foreground: [
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
          pos: Offset(-500, 30),
          size: Offset(1000, 20),
        ),
        Platform.create(
          game: game,
          color: Color(0xff333333),
          pos: Offset(100, -10),
          size: Offset(100, 40),
        ),
        Platform.create(
          game: game,
          color: Color(0xff333333),
          pos: Offset(400, -100),
          size: Offset(100, 150),
        ),
      ],
    },
  );
}
