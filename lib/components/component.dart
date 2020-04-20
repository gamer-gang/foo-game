import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../game.dart';

class GameObject {
  MonumentPlatformer game;
  Offset pos;

  List<GameObject> children = List<GameObject>();

  @mustCallSuper
  GameObject.create(MonumentPlatformer game) {
    this.game = game;
  }

  void render(Canvas c) {
    children.forEach((child) => child.render(c));
  }

  void update(double t) {
    children.forEach((child) => child.update(t));
  }

  void addChild(GameObject child) {
    children.add(child);
  }

  void removeChild(GameObject child) {
    for (GameObject obj in children) {
      if (obj == child) {
        children.remove(obj);
      }
    }
  }
}

mixin RectProperties on GameObject {
  Offset size;
  Rect toRect() => Rect.fromLTWH(pos.dx, pos.dy, size.dx, size.dy);
  get left => pos.dx;
  get top => pos.dy;
  get right => pos.dx + size.dx;
  get bottom => pos.dy + size.dy;
}