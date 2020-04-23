import 'dart:ui';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/painting.dart';
import '../game.dart';

import 'component.dart';

class Text extends GameObject {
  TextAlign align;
  TextPainter painter;
  Offset pos;
  TextStyle style;
  String text;

  Text.create({
    MonumentPlatformer game,
    this.text,
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

  Text.monospace(MonumentPlatformer game) : super.create(game) {
    text = '';
    painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: Colors.black,
          fontFamily: "Fira Code",
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    );
  }

  Text.sansSerif(MonumentPlatformer game) : super.create(game) {
    text = '';
    painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: Colors.black,
          fontFamily: "PT Sans",
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
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

  void setStyle(TextStyle newStyle) {
    style = style.merge(newStyle);
  }
}
