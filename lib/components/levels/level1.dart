import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../../game.dart';
import '../background.dart';
import '../checkpoint.dart';
import '../goal.dart';
import '../level.dart';
import '../platform.dart';
import 'index.dart' show platformColor;

Level level1(MonumentPlatformer game) {
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
        Checkpoint.create(game: game, pos: Offset(430, -190)),
        // Obtainable.create(
        //   game: game,
        //   debug: true,
        //   child: Platform.create(
        //     game: game,
        //     color: Colors.orange,
        //     pos: Offset(420, -150),
        //     size: Offset(50, 50),
        //   ),
        // ),
        ...Platform.many(
          common: Platform.create(
            game: game,
            color: platformColor,
          ),
          properties: [
            {'pos': Offset(-500, 30), 'size': Offset(1000, 20)},
            {'pos': Offset(100, -10), 'size': Offset(100, 40)},
            {'pos': Offset(100, -250), 'size': Offset(100, 40)},
            {'pos': Offset(400, -100), 'size': Offset(100, 150)},
            {'pos': Offset(200, -450), 'size': Offset(100, 40)},
            {'pos': Offset(500, -450), 'size': Offset(100, 40)},
            {
              'color': Colors.red,
              'canKillPlayer': true,
              'pos': Offset(350, -660),
              'size': Offset(250, 150),
            },
            {
              'color': Colors.red,
              'canKillPlayer': true,
              'pos': Offset(600, -450),
              'size': Offset(100, 40),
            },
            {
              'pos': Offset(700, -600), 'size': Offset(100, 190),
            },
          ],
        ),

        Goal.create(
          game: game,
          pos: Offset(620, -580),
          color: Colors.purple,
        ),
        // Platform.create(
        //   game: game,
        //   color: platformColor,
        //   pos: Offset(200, -450),
        //   size: Offset(100, 40),
        // ),
        // Platform.create(
        //   game: game,
        //   color: platformColor,
        //   pos: Offset(500, -450),
        //   size: Offset(500, -450),
        // ),
        // Platform.create(
        //   game: game,
        //   color: Colors.red,
        //   canKillPlayer: true,
        //   pos: Offset(350, -660),
        //   size: Offset(100, 150),
        // ),
        // Platform.create(
        //   game: game,
        //   color: platformColor,
        //   pos: Offset(-500, 30),
        //   size: Offset(1000, 20),
        // ),
        // Platform.create(
        //   game: game,
        //   color: platformColor,
        //   pos: Offset(100, -10),
        //   size: Offset(100, 40),
        // ),
        // Platform.create(
        //   game: game,
        //   color: platformColor,
        //   pos: Offset(100, -250),
        //   size: Offset(100, 40),
        // ),
        // Platform.create(
        //   game: game,
        //   color: platformColor,
        //   pos: Offset(400, -100),
        //   size: Offset(100, 150),
        // ),
      ],
    },
  );
}
