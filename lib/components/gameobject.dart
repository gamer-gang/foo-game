import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../common.dart';
import '../game.dart';

abstract class GameObject {
  MonumentPlatformer game;
  Offset pos, vel;
  bool canKillPlayer;
  bool collide;

  @mustCallSuper
  GameObject.create(this.game) {
    collide ??= false;
  }

  void render(Canvas c);

  // not making this abstract because it isn't required
  void update(double t) {}

  double get left => pos.dx;
  double get top => pos.dy;
}

mixin RectProperties on GameObject {
  Offset size;
  Offset vel;
  int jumps;
  int dashes;
  int dashFrames;

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
        // kill player!!!!!!!!
      } else {
        for (var i = 0; i < 20; i++) {
          // if we are still overlapping with the platform, we get moved up.
          if (toRect().overlaps(other.toRect())) pos = pos.withY(pos.dy - 1);
        }
        if (toRect().overlaps(other.toRect())) pos = pos.withY(pos.dy + 20);
        // move us back down if we are still stuck
        for (var i = 0; i < 20; i++) {
          // same old, same old
          if (toRect().overlaps(other.toRect())) pos = pos.withY(pos.dy + 1);
        }
        if (toRect().overlaps(other.toRect())) pos = pos.withY(pos.dy - 20);

        for (var i = 0; i < 20; i++) {
          // same thing but side to side, side side to side
          if (toRect().overlaps(other.toRect())) pos = pos.withX(pos.dx - 1);
        }
        if (toRect().overlaps(other.toRect())) pos = pos.withX(pos.dx + 20);

        for (var i = 0; i < 20; i++) {
          if (toRect().overlaps(other.toRect())) pos = pos.withX(pos.dx + 1);
        }
        if (toRect().overlaps(other.toRect())) pos = pos.withX(pos.dx - 20);

        if (bottom + 1 > other.top) {
          // we are on the top of the platform!
          if (vel.dy > 0) {
            vel = vel.withY(0);
          } // make the y velocity 0 on platform
          jumps = 1;
          dashes = 1;
        }

        if (left < other.right || right > other.left) {
          if (dashFrames != 0) {
            dashFrames = 0;
            print('bump');
            vel = Offset(-vel.dx, -20);
          }
        }

        // var distanceToTop = (bottom - other.top).abs();
        // var distanceToBottom = (top - other.bottom).abs();
        // var distanceToRight = (left - other.right).abs();
        // var distanceToLeft = (right - other.left).abs();

        // if (distanceToTop < distanceToBottom) {
        //   if (vel.dy > 0) vel = vel.withY(0);
        //   // make the y velocity 0 on platform
        //   pos = pos.withY(other.top - size.dy);
        //   jumps = 1;
        //   dashes = 1;
        // } else if (distanceToTop > distanceToBottom) {
        //   pos = pos.withY(other.bottom);
        // } else if (distanceToRight < distanceToLeft) {
        //   pos = pos.withX(other.left - size.dx);
        //   dashFrames = 0;
        // } else {
        //   pos = pos.withX(other.left - size.dx);
        //   dashFrames = 0;
        // }
      }
      // else if (toRect().intersect(other.toRect()).width < 3.66) {
      //   if (right >= other.left && right <= other.right) {
      //     // we are sliding into the left of the platform; move to the left
      //     pos = pos.withX(other.left - size.dx);
      //     dashFrames = 0;
      //   } else if (left >= other.left && left <= other.right) {
      //     // we are sliding into the right of the platform; move to the right
      //     pos = pos.withX(other.right);
      //     dashFrames = 0;
      //   }
      // } else if (bottom >= other.top && bottom <= other.bottom) {
      //   // we are falling through the platform; move to the top
      //   pos = pos.withY(other.top - size.dy);
      //   jumps = 1;
      //   if (vel.dy > 0) vel = vel.withY(0); // make the y velocity 0 on platform
      //   dashes = 1;
      // } else if (top >= other.top && top <= other.bottom) {
      //   // we are hitting the bottom of the platform; move to the bottom
      //   pos = pos.withY(other.bottom);
      // }
    }
  }
}
