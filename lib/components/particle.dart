import 'dart:math';
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart' show Colors;

// import '../common.dart';
import '../game.dart';
import 'gameobject.dart';

class ParticleEffect extends GameObject {
  List<GameParticle> particles;
  GameParticle particle;
  int particleCount;

  ParticleEffect.create({
    MonumentPlatformer game,
    this.particle,
    this.particleCount,
  }) : super.create(game) {
    for (var i = 0; i < particleCount; i++) {
      particles.add(particle);
    }
  }

  ParticleEffect.dead(MonumentPlatformer game) : super.create(game) {
    // TODO assign this.particle & this.particleCount
    for (var i = 0; i < particleCount; i++) {
      particles.add(particle);
    }
  }

  void update(double t) {
    for (var i = 0; i < particles.length; i++) {
      particles[i].update(t);
    }
  }

  void render(Canvas c) {
    for (var i = 0; i < particles.length; i++) {
      particles[i].render(c);
    }
  }
}

class GameParticle extends GameObject {
  int lifetime, points;
  // points is how many points the particle will have (always regular polygon)
  double angle = 0, angVel = 0, angFriction = 0.8, friction = 0.8, radius;
  // angle is measured in degrees, friction is multiplied every frame
  Offset pos, vel; // position is measured from the center
  Color color = Colors.black;

  GameParticle.create(
    MonumentPlatformer game,
    this.points,
    this.lifetime,
    this.points,
    this.angle,
    this.angVel,
    this.angFriction,
    this.pos,
    this.vel,
    this.friction,
    this.color,
  ) : super.create(game);

  void update(double t) {
    pos += vel;
    vel *= friction;
    lifetime--;
  }

  void render(Canvas c) {
    List<Offset> vertices;
    var paint = Paint()..color = color;
    var angles = 2 * pi / points;

    for (var i = 0; i < points; i++) {
      vertices.add(Offset(
        pos.dx + cos(angles * i) * radius,
        pos.dy + sin(angles * i) * radius,
      ));
    }
    vertices.add(Offset(pos.dx + radius, pos.dy));

    c.drawPoints(PointMode.polygon, vertices, paint);
  }
}
