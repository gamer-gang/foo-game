import 'dart:ui';

import 'package:flutter/material.dart' hide Text;

import '../common.dart';
import '../game.dart';
import 'gameobject.dart';
import 'text.dart';

double _strokeWidth = 4;

class Obtainable extends GameObject {
  RectProperties child;
  bool debug;
  Text debugText;

  Obtainable.create({
    MonumentPlatformer game,
    this.child,
    this.debug = false,
  }) : super.create(game) {
    if (debug) {
      debugText = Text.monospace(game)
        ..pos = child.pos.withY(child.pos.dy - 14)
        ..text = 'OBTAINABLE'
        ..style = TextStyle(
          letterSpacing: 1.2,
          color: Colors.red.shade800,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        );
    }
  }

  void render(Canvas c) {
    child.render(c);
    if (debug) {
      c.drawPoints(
        PointMode.polygon,
        [
          // top left
          child.pos.translate(_strokeWidth / 2, _strokeWidth / 2),
          // top right
          child.pos
              .translateX(child.width)
              .translate(-_strokeWidth / 2, _strokeWidth / 2),
          // bottom right
          child.pos +
              child.size.translate(-_strokeWidth / 2, -_strokeWidth / 2),
          // bottom left
          child.pos
              .translateY(child.height)
              .translate(_strokeWidth / 2, -_strokeWidth / 2)
        ],
        Paint()
          ..color = Colors.red.shade800
          ..strokeCap = StrokeCap.square
          ..strokeWidth = _strokeWidth,
      );

      debugText.render(c);
    }
  }

  void update(double t) {
    debugText.pos = child.pos.translateY(-14);
  }
}
