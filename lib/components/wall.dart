import 'dart:ui';

import '../game.dart';
import 'core/gameobject.dart';

class Wall extends GameObject {
  Wall({MonumentPlatformerGame game, double x, double y, double width, double height,
      int colorCode})
      : super(game) {
    this.colorCode = colorCode;
    rect = Rect.fromLTWH(x, y, width, height);
    paint = Paint();
    paint.color = Color(colorCode);
  }

  int colorCode;
  Paint paint;
  Rect rect;

  @override
  void render(Canvas c) {
    c.drawRect(rect, paint);
  }
}
