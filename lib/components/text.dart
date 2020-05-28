import 'dart:ui';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/painting.dart';
import '../game.dart';

import 'gameobject.dart';

class Text extends GameObject {
  TextAlign align;
  TextPainter painter;
  Offset pos;
  TextStyle _style;

  String _text;

  Text.create({
    MonumentPlatformer game,
    String text,
    TextStyle style,
    this.pos,
    this.align,
  }) : super.create(game) {
    _text = text;
    _style = style;
    painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textAlign: align,
    );
  }

  // TODO convert to factory
  Text.monospace(MonumentPlatformer game) : super.create(game) {
    text = '';
    painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: Colors.blue,
          fontFamily: "Fira Code",
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    );
  }

  // TODO convert to factory
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

  String get text => _text;
  set text(String text) {
    _text = text;
    painter.text = TextSpan(text: _text, style: style);
  }

  TextStyle get style => _style;
  set style(TextStyle style) {
    _style = style.merge(_style);
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
