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
  Offset offset;
  OffsetType offsetType;

  TextComponent({
    this.game,
    String text,
    double fontSize,
    double y,
    TextAlign align = TextAlign.center,
    int colorCode = 0xfffafafa,
    Offset offset = Offset.zero,
    OffsetType offsetType = OffsetType.fixed,
  }) : super(game) {
    this.fontSize = fontSize;
    this.displayString = text;
    this.y = y;
    painter = TextPainter(
      textAlign: align,
      textDirection: TextDirection.ltr,
    );
    textStyle = TextStyle(
      fontFamily: 'PTSans',
      fontWeight: FontWeight.bold,
      color: Color(colorCode),
      fontSize: fontSize,
    );
    this.offset = offset;
    this.offsetType = offsetType;
  }

  void setText(String text) {
    this.displayString = text;
  }

  Rect toRect() {
    return Rect.fromLTWH((game.viewport.width / 2) - (painter.width / 2), y - (painter.height / 2), painter.width, painter.height);
  }

  @override
  void render(Canvas c) {
    updateWithOffset();
    painter.paint(c, this.position);
  }


  void updateWithOffset() {
    // ignore: deprecated_member_use
    if ((painter.text?.text ?? '') != displayString) {
      painter.text = TextSpan(
        text: displayString,
        style: textStyle,
      );
      painter.layout();
    }

    switch (this.offsetType) {
      case OffsetType.specified:
        this.position = this.offset;
        break;
      case OffsetType.fixed:
        this.position = Offset(
          (game.viewport.width / 2) - (painter.width / 2),
          y - (painter.height / 2),
        );
        break;
    }
  }
}

enum OffsetType { specified, fixed }
