import 'dart:ui';

import '../game.dart';
import 'component.dart';

class Player extends GameObject {
  MonumentPlatformer game;
  Color color;
  Offset pos; // note: abb. for position
  Offset size; // note: not an abbreviation
  Offset vel; // note: abb. for velocity
  
  bool dead;

  static double speed = 5;
  static double maxSpeed = 5;
  static double friction = 0.1;

  // vc?
  
  Player({
    this.game,
    Offset initialPosition,
    this.size,
    this.color,
  }) {
    pos = initialPosition;
    dead = false;
    vel = Offset(0, 0);
  }

  void render(Canvas c) {
    if (dead) dead = true; // do something

    Paint paint = Paint()..color = color;
    c.drawRect(Rect.fromLTWH(pos.dx, pos.dy, size.dx, size.dy), paint);
  }
  
  void update(double t) {
    if(checkDeath()) dead = true;
    vel = Offset(
      vel.dx.abs() > Player.maxSpeed ? Player.maxSpeed * vel.dx.sign : vel.dx,
      vel.dy.abs() > Player.maxSpeed ? Player.maxSpeed * vel.dy.sign : vel.dy,
    );

    // TODO: platform collision

    pos += vel;
    vel = vel * Player.friction;
  } 
  
  void move(Gamepad gamepad) {
    if (gamepad.left) 
      vel = vel.translate(-Player.speed, 0);
    
    if (gamepad.right) 
      vel = vel.translate(Player.speed, 0);
    
  }

  bool checkDeath() {
    return false;
  }
}