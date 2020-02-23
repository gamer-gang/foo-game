import 'dart:ui';

import 'object.dart';
import '../game.dart';

class Ground extends GameObject {
  Rect rect;
  Paint paint;

  int colorCode;

  Ground(MainGame game, double x, double y, double width, double height, int colorCode) : super(game) {
    this.colorCode = colorCode;
    rect = Rect.fromLTWH(x, y, width, height);
    paint = Paint();
    paint.color = Color(colorCode);
  }

  @override
  void render(Canvas c) {
    c.drawRect(rect, paint);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}
