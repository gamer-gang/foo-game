import 'dart:ui';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/painting.dart';
import '../game.dart';

import 'gameobject.dart';

class Text extends GameObject {
  TextStyle _style;
  String _text;

  TextAlign align;
  TextPainter painter;
  Offset pos;

  String get text => _text;

  set text(String text) {
    _text = text;
    painter.text = TextSpan(text: this.text, style: style);
  }

  TextStyle get style => _style;

  set style(TextStyle style) {
    _style = (_style ?? TextStyle()).merge(style);
    painter.text = TextSpan(text: text, style: this.style);
  }

  Text.create({
    MonumentPlatformer game,
    this.pos,
  }) : super.create(game) {
    painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textAlign: align ?? TextAlign.left,
    );
  }

  Text.monospace(MonumentPlatformer game) : super.create(game) {
    painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    );
    text = '';
    style = TextStyle(
      color: Colors.black,
      fontFamily: "Fira Code",
    );
  }

  Text.sansSerif(MonumentPlatformer game) : super.create(game) {
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
    text = '';
  }

  void render(Canvas c) {
    painter.layout();
    painter.paint(c, pos);
  }

  void update(double t) {}
<<<<<<<

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
=======

>>>>>>>
}
