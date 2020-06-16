import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../../game.dart';
import '../background.dart';
import '../checkpoint.dart';
// import '../crystals.dart';
// import '../goal.dart';
import '../level.dart';
import '../platform.dart';
import 'index.dart' show platformColor;

Level level3(MonumentPlatformer game) {
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
        ...Platform.many(
          common: Platform.create(
            game: game,
            color: platformColor,
          ),
          properties: [
            {'pos': Offset(-25, 30), 'size': Offset(100, 40)},
            {
              'color': Colors.red,
              'canKillPlayer': true,
              'pos': Offset(-25, -300),
              'size': Offset(100, 40)
            },
            {'pos': Offset(75, -200), 'size': Offset(100, 40)},
            {'pos': Offset(-25, -340), 'size': Offset(100, 40)},
          ],
        ),
        Checkpoint.create(pos: Offset(100, -290), game: game),
      ]
    },
  );
}
