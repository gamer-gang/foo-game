import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../game.dart';
import 'gameobject.dart';

/// An object for rendering a single color, gradient, etc.
/// Should be placed in thr background layer.
class Background extends GameObject {
  Color color;
  Paint paint;

  Background.create({
    @required MonumentPlatformer game,
    @required this.color,
  }) : super.create(game) {
    paint = Paint()..color = color;
  }

  void render(Canvas c) {
    c.drawRect(
      Rect.fromLTWH(0, 0, game.viewport.width, game.viewport.height),
      paint,
    );
  }

  void update(double t) {}

  // if (pos.dx < 50)
  //   paint.color = Color(0xffffffff);
  // else if (pos.dx < 100)
  //   paint.color = Color(0xffcccccc);
  // else if (pos.dx < 150)
  //   paint.color = Color(0xff999999);
  // else if (pos.dx < 200)
  //   paint.color = Color(0xff444444);
  // else
  //   paint.color = Color(0xff111111);

  // LinearGradient gradient = LinearGradient(
  //   colors: [
  //     Color(0xffffffff),
  //     Color(0xff000000)
  //   ]
  // );

  // paint.shader = gradient.createShader(
  //    Rect.fromLTWH(0, 0, game.viewport.width, game.viewport.height));
}
