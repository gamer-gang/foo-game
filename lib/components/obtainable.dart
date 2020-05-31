import 'dart:ui';

import 'package:flutter/material.dart' hide Text;

import '../common.dart';
import '../game.dart';
import 'gameobject.dart';
import 'text.dart';

double _strokeWidth = 4;

class Obtainable extends GameObject with RectProperties {
  RectProperties child;
  bool debug;
  Text debugText;

  /// Alias for `child.right`
  double get right => child.right;

  /// Alias for `child.bottom`
  double get bottom => child.bottom;

  /// Alias for `child.width`
  double get width => child.width;

  /// Alias for `child.height`
  double get height => child.height;

  Offset get pos => child.pos;
  Offset get size => child.size;
  Rect toRect() => child.toRect();

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
          letterSpacing: 1.3,
          color: Colors.red.shade700,
          fontWeight: FontWeight.w600,
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
              .translate(_strokeWidth / 2, -_strokeWidth / 2),
          // top left
          child.pos.translate(_strokeWidth / 2, _strokeWidth / 2),
        ],
        Paint()
          ..color = Colors.red.shade700
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
