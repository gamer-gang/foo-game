import 'dart:ui';

import 'package:flutter/rendering.dart';

import '../game.dart';
import 'component.dart';

class Background extends GameObject {
  final Gradient gradient = LinearGradient(
    begin: Alignment.topCenter,
    colors: <Color>[
      Color.fromARGB(255, 1, 101, 177),
      Color.fromARGB(255, 255, 255, 255),
    ],
    stops: [
      0.0,
      1.0,
    ],
    end: Alignment(0, 01),
  );
  Rect rect;
  Paint paint;
  Background({
    MonumentPlatformer game,
    double x,
    double y,
    double width,
    double height,
  }) : super(game) {
    paint = Paint();
    paint.color = Color(0xff77b5e1);

    rect = Rect.fromLTWH(x, y, width, height);
    paint = new Paint()..shader = gradient.createShader(rect);
  }

  @override
  void render(Canvas c) {
    c.drawRect(rect, paint);
    // super.render(c);
  }

  @override
  void update(double t) {
    super.update(t);
  }
}
