import 'dart:ui';

import 'package:flutter/painting.dart';

import '../game.dart';
import 'core/gameobject.dart';

class TextComponent extends GameObject {
  final MonumentPlatformerGame game;
  TextPainter painter;
  TextStyle textStyle;
  String displayString;
  Offset position;
  double fontSize;
  double y;

  TextComponent({
    this.game,
    String text,
    double fontSize,
    double y,
    int colorCode = 0xfffafafa,
  }) : super(game) {
    this.fontSize = fontSize;
    this.displayString = text;
    this.y = y;
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textStyle = TextStyle(
      fontFamily: 'Baloo',
      color: Color(colorCode),
      fontSize: fontSize,
    );
    position = Offset.zero;
  }

  void setText(String text) {
    this.displayString = text;
  }

  Rect toRect() {
    return Rect.fromLTWH((game.viewport.width / 2) - (painter.width / 2),
        y - (painter.height / 2), painter.width, painter.height);
  }

  @override
  void render(Canvas c) {
    painter.paint(c, position);
  }

  @override
  void update(double t) {
    // ignore: deprecated_member_use
    if ((painter.text?.text ?? '') != displayString) {
      painter.text = TextSpan(
        text: displayString,
        style: textStyle,
      );
      painter.layout();
      position = Offset(
        (game.viewport.width / 2) - (painter.width / 2),
        y - (painter.height / 2),
      );
    }
  }
}
