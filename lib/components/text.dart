import 'dart:math';
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

  /// rotation in degrees clockwise
  int rotation = 0;

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

  Text.create(MonumentPlatformer game) : super.create(game) {
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

    c.save();
    c.translate(pos.dx, pos.dy);
    c.rotate(rotation * (pi / 180));

    painter.paint(c, Offset.zero);

    c.restore();
  }

  void update(double t) {}
}
