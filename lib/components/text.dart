import 'dart:ui';
import 'package:flutter/painting.dart';

import 'component.dart';

class Text extends GameObject {
  String text;
  TextPainter painter;
  TextStyle style;
  TextAlign align;
  Offset pos;
  double size;

  Text({
    this.text,
    this.size,
    this.style,
    this.pos,
    this.align,
  }) {
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
