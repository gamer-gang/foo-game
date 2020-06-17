import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../game.dart';
import 'gameobject.dart';

class Platform extends GameObject with RectProperties {
  Color color;
  bool canKillPlayer, collide;
  Offset pos, size;

  Platform.create({
    @required MonumentPlatformer game,
    this.color,
    this.canKillPlayer = false,
    this.collide = true,
    this.pos,
    this.size,
  }) : super.create(game);

  static List<Platform> many({
    Platform common,
    List<Map<String, dynamic>> properties,
  }) {
    var output = <Platform>[];
    for (final props in properties) {
      output.add(Platform.create(
        color: props['color'] ?? common.color,
        game: props['game'] ?? common.game,
        pos: props['pos'] is Offset
            ? props['pos']
            : Offset(
                  props['pos'][0],
                  props['pos'][0],
                ) ??
                common.pos,
        size: props['size'] is Offset
            ? props['size']
            : Offset(
                  props['size'][0],
                  props['size'][0],
                ) ??
                common.size,
        collide: props['collide'] ?? common.collide,
        canKillPlayer: props['canKillPlayer'] ?? common.canKillPlayer,
      ));
    }
    return output;
  }

  void render(Canvas c) {
    var paint = Paint()..color = color;
    c.drawRect(Rect.fromLTWH(pos.dx, pos.dy, size.dx, size.dy), paint);
  }

  void update(double t) {}
}
