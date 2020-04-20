import 'dart:ui';
import 'package:flutter/painting.dart';
import '../game.dart';

import 'component.dart';

class Text extends GameObject {
  TextAlign align;
  TextPainter painter;
  Offset pos;
  double size;
  TextStyle style;
  String text;

  Text.create({
    MonumentPlatformer game,
    this.text,
    this.size,
    this.style,
    this.pos,
    this.align,
  }) : super.create(game) {
    painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textAlign: align,
    );
  }

  void render(Canvas c) {
    painter.layout();
    painter.paint(c, pos);
  }

  void update(double t) {}

  void setText(String newText) {
    text = newText;
    painter.text = TextSpan(text: text, style: style);
  }

  void setPos(Offset newPos) {
    pos = newPos;
  }
}
