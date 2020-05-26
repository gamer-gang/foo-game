import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../common.dart';
import '../game.dart';

abstract class GameObject {
  MonumentPlatformer game;
  Offset pos, vel;
  bool canKillPlayer;
  bool collide = false;

  @mustCallSuper
  GameObject.create(this.game);

  void render(Canvas c);

  // not making this abstract because it isn't required
  void update(double t) {}

  double get left => pos.dx;
  double get top => pos.dy;
}

mixin RectProperties on GameObject {
  Offset size;
  int jumps;
  int dashes;

  Rect toRect() => Rect.fromLTWH(pos.dx, pos.dy, size.dx, size.dy);

  /// Alias for `pos.dx + size.dx`
  double get right => pos.dx + size.dx;
  /// Alias for `pos.dy + size.dy`
  double get bottom => pos.dy + size.dy;

  /// Alias for `size.dx`
  double get width => size.dx;
  /// Alias for `size.dy`
  double get height => size.dy;

  void collideWith(RectProperties other) {
    if (toRect().overlaps(other.toRect())) {
      // we are intersecting the platform im some way

      if (other.canKillPlayer) {
        // TODO kill player
      } else if (toRect().intersect(other.toRect()).width < 3.66) {
        if (right >= other.left && right <= other.right) {
          // we are sliding into the left of the platform; move to the left
          pos = pos.withX(other.left - size.dx);
        } else if (left >= other.left && left <= other.right) {
          // we are sliding into the right of the platform; move to the right
          pos = pos.withX(other.right);
        }
      } else if (bottom >= other.top && bottom <= other.bottom) {
        // we are falling through the platform; move to the top
        pos = pos.withY(other.top - size.dy);
        if (vel.dy > 0) vel = vel.withY(0); // make the y velocity 0 on platform
        jumps = 1;
        dashes = 1;
      } else if (top >= other.top && top <= other.bottom) {
        // we are hitting the bottom of the platform; move to the bottom
        pos = pos.withY(other.bottom);
      }
    }
  }
}
