import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../game.dart';
import '../common.dart';

class GameObject {
  MonumentPlatformer game;
  Offset pos;
  Offset vel;
  bool canKillPlayer;
  bool collide = false;

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
  int jumps;

  Rect toRect() => Rect.fromLTWH(pos.dx, pos.dy, size.dx, size.dy);
  double get left => pos.dx;
  double get top => pos.dy;
  double get right => pos.dx + size.dx;
  double get bottom => pos.dy + size.dy;

  void collideWith(RectProperties other) {
    if (this.toRect().overlaps(other.toRect())) {
      // we are intersecting the platform im some way

      if (other.canKillPlayer) {
        // kill player
      } else if (this.toRect().intersect(other.toRect()).width < 3.66) {
        if (this.right >= other.left && this.right <= other.right) {
          // we are sliding into the left of the platform; move to the left
          pos = pos.withX(other.left - size.dx);
        } else if (this.left >= other.left && this.left <= other.right) {
          // we are sliding into the right of the platform; move to the right
          pos = pos.withX(other.right);
        }
      } else if (this.bottom >= other.top && this.bottom <= other.bottom) {
        // we are falling through the platform; move to the top
        pos = pos.withY(other.top - size.dy);
        if(vel.dy > 0) vel = vel.withY(0); // make the y velocity 0 on platform
        this.jumps = 1;
      } else if (this.top >= other.top && this.top <= other.bottom) {
        // we are hitting the bottom of the platform; move to the bottom
        pos = pos.withY(other.bottom);
      }
    }
  }
}
