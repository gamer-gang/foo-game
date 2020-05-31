import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../../game.dart';
import '../background.dart';
import '../level.dart';
import '../obtainable.dart';
import '../platform.dart';

Level level1(MonumentPlatformer game) {
  var platformColor = Color(0xff333333);

  return Level.create(
    game: game,
    layers: {
      Layers.background: [
        Background.create(
          game: game,
          color: Color(0xffffffff),
        ),
      ],
      Layers.foreground: [
        Obtainable.create(
          game: game,
          debug: true,
          child: Platform.create(
            game: game,
            color: Colors.orange,
            pos: Offset(420, -150),
            size: Offset(50, 50),
          ),
        ),
        Platform.create(
          game: game,
          color: platformColor,
          pos: Offset(-500, 30),
          size: Offset(1000, 20),
        ),
        Platform.create(
          game: game,
          color: platformColor,
          pos: Offset(100, -10),
          size: Offset(100, 40),
        ),
        Platform.create(
          game: game,
          color: platformColor,
          pos: Offset(100, -250),
          size: Offset(100, 40),
        ),
        Platform.create(
          game: game,
          color: platformColor,
          pos: Offset(400, -100),
          size: Offset(100, 150),
        ),
      ],
    },
  );
}
