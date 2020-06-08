import 'dart:math';
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart' show Colors;

// import '../common.dart';
import '../game.dart';
import 'gameobject.dart';

class ParticleManager {
  final List<ParticleEffect> _particles;

  ParticleManager({
    List<ParticleEffect> particles,
  }) : _particles = particles ?? [];

  int add(ParticleEffect particle) {
    _particles.add(particle);
    return _particles.length - 1;
  }

  void remove(ParticleEffect particle) => _particles.remove(particle);
  void removeAt(int index) => _particles.removeAt(index);
  void clear() => _particles.clear();

  void indexOf(ParticleEffect particle) => _particles.indexOf(particle);
  
  void renderAt(int index, Canvas c) => _particles[index].render(c);
  void renderAll(Canvas c) {
    for (final particle in _particles) {
      particle.render(c);
    }
  }
  
  void updateAt(int index, double t) => _particles[index].update(t);
  void updateAll(double t) {
    for (final particle in _particles) {
      particle.update(t);
    }
  }
}

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
  double angle, angleVelocity, angleFriction, friction, radius;
  // angle is measured in degrees, friction is multiplied every frame
  Offset pos, vel; // position is measured from the center
  Color color = Colors.black;

  GameParticle.create({
    MonumentPlatformer game,
    this.points = 3,
    this.lifetime,
    this.angle = 0,
    this.angleVelocity = 0,
    this.angleFriction = 0.8,
    this.pos,
    this.vel,
    this.friction = 8,
    this.color,
  }) : super.create(game);

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
