import 'dart:ui';

import '../game.dart';
import 'gameobject.dart';
// import 'player.dart';

enum Replenish { dash, jump, both }

class Crystal extends GameObject {
  Offset pos;
  Color color, defaultColor;
  Replenish replenish;
  int id;

  Crystal.create({
    MonumentPlatformer game,
    this.pos,
    this.defaultColor,
    this.replenish,
  }) : super.create(game) {
    color = defaultColor;
  }

  void render(Canvas c) {
    var path = Path();
    var center = pos + Offset(10, 10);
    var vertecies = <Offset>[
      center + Offset(15, 0),
      center + Offset(0, 15),
      center - Offset(15, 0),
      center - Offset(0, 15),
    ];
    path.addPolygon(vertecies, true);

    c.drawPath(path, Paint()..color = color);
  }

  void update(double t) {
    if (game.player.crystalsUsed.contains(this)) {
      color = Color(0xff696969);
    } else {
      color = defaultColor;
    }
  }
}
