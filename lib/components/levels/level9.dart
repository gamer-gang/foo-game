import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../../game.dart';
import '../background.dart';
import '../level.dart';

Level level9(MonumentPlatformer game) {
  // var platformColor = Color(0xff333333);

  return Level.create(
    game: game,
    layers: {
      Layers.background: [
        Background.create(
          game: game,
          color: Color(0xffffffff),
        ),
      ],
      Layers.foreground: [],
    },
  );
}
