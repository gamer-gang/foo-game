import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../../game.dart';
import '../background.dart';
// import '../checkpoint.dart';
import '../crystals.dart';
import '../goal.dart';
import '../level.dart';
import '../platform.dart';
import 'index.dart' show platformColor;

Level level2(MonumentPlatformer game) {
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
              'pos': Offset(-25, -80),
              'size': Offset(300, 40)
            },
            {
              'color': Colors.red,
              'canKillPlayer': true,
              'pos': Offset(-65, -80),
              'size': Offset(40, 150)
            },
            {'pos': Offset(-65, -120), 'size': Offset(340, 40)},
            {
              'color': Colors.red,
              'canKillPlayer': true,
              'pos': Offset(-265, -120),
              'size': Offset(100, 80),
            },
            {'pos': Offset(-265, 30), 'size': Offset(100, 40)},
          ],
        ),
        Crystal.create(
          pos: Offset(300, -60),
          game: game,
          defaultColor: Colors.blue,
          replenish: Replenish.both,
        ),
        Goal.create(
          game: game,
          pos: Offset(-245, -30),
          color: Colors.orange,
        ),
      ]
    },
  );
}
