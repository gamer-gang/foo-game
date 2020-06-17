import 'dart:math';
// import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart' show Colors;

import '../common.dart';
import '../game.dart';
import 'gameobject.dart';

class ParticleManager {
  final List<dynamic> _particles;

  ParticleManager({
    List<dynamic> particles,
  }) : _particles = particles ?? [];

  int add(dynamic particle) {
    _particles.add(particle);
    return _particles.length - 1;
  }

  void remove(dynamic particle) => _particles.remove(particle);
  void removeAt(int index) => _particles.removeAt(index);
  void clear() => _particles.clear();

  void indexOf(dynamic particle) => _particles.indexOf(particle);

  void renderAt(int index, Canvas c) => _particles[index].render(c);
  void renderAll(Canvas c) {
    for (final particle in _particles) {
      particle.render(c);
    }
  }

  void updateAt(int index, double t) => _particles[index].update(t);
  void updateAll(double t) {
    for (var particleIndex = 0;
        particleIndex < _particles.length;
        particleIndex++) {
      _particles[particleIndex].update(t);
    }
  }
}

class ParticleEffect extends GameObject {
  List<GameParticle> particles;

  ParticleEffect.create({
    MonumentPlatformer game,
    this.particles,
  }) : super.create(game);

  factory ParticleEffect.checkpoint({MonumentPlatformer game, Offset pos}) {
    return ParticleEffect.create(particles: [
      GameParticle.create(
        pos: pos,
        vel: Offset(0, 1),
        color: Color(0xaa90ff1e),
        manager: game.particleManager,
        points: 3,
        angle: Random().nextDouble() * pi * 2 / 3,
        angleVelocity: Random().nextDouble() * 0.5 - 0.25,
      )
    ]);
  }

  factory ParticleEffect.death({MonumentPlatformer game, Offset pos}) {
    return ParticleEffect.create(particles: [
      for (int i = 0, total = Random().nextInt(10) + 10; i < total; i++)
        GameParticle.create(
          pos: pos,
          vel: Offset(
            Random().nextInt(50) - 25.toDouble(),
            -Random().nextInt(25) - 20.toDouble(),
          ),
          color: Color(0xff1e90ff),
          manager: game.particleManager,
          points: Random().nextInt(3) + 2,
          angle: 0, // Random().nextInt(10).toDouble(),
          fall: true,
          radius: 10,
          friction: 0.94,
        ),
    ]);
  }

  factory ParticleEffect.ambientGoalEffect({
    MonumentPlatformer game,
    Offset pos,
    Color color,
  }) {
    print(color.toString());
    return ParticleEffect.create(particles: [
      GameParticle.create(
        pos: pos +
            Offset(Random().nextInt(60).toDouble(),
                Random().nextInt(60).toDouble()),
        vel: Offset(0, 1),
        color: color.withBrightness(2),
        manager: game.particleManager,
        points: 3,
        angle: Random().nextDouble() * pi * 2 / 3,
        angleVelocity: Random().nextDouble() * 0.5 - 0.25,
      )
    ]);
  }

  factory ParticleEffect.goal({MonumentPlatformer game, Offset pos}) {
    return ParticleEffect.create(particles: [
      for (int i = 0, total = Random().nextInt(15) + 5; i < total; i++)
        GameParticle.create(
          pos: pos,
          vel: Offset(
            Random().nextInt(50) - 25.toDouble(),
            Random().nextInt(50) - 25.toDouble(),
          ),
          color: Color(0xff1e90ff),
          manager: game.particleManager,
          points: Random().nextInt(3) + 2,
          angle: 0, // Random().nextInt(10).toDouble(),
          radius: 10,
          friction: 0.8,
        ),
    ]);
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

  bool fall;

  ParticleManager manager;

  GameParticle.create({
    MonumentPlatformer game,
    this.manager,
    this.points = 5,
    this.radius = 5,
    this.lifetime = 60,
    this.angle = 0,
    this.angleVelocity = 0,
    this.angleFriction = 1,
    this.pos,
    this.vel,
    this.friction = 1,
    this.color = Colors.white,
    this.fall = false,
  }) : super.create(game) {
    manager.add(this);
  }

  void update(double t) {
    angle += angleVelocity;
    angleVelocity *= angleFriction;
    pos += vel;
    vel *= friction;
    if (fall) {
      vel = Offset(vel.dx, vel.dy + 5);
    }
    lifetime--;
    if (lifetime == 0) manager.remove(this);
  }

  void render(Canvas c) {
    var vertices = <Offset>[];
    var paint = Paint()..color = color;
    var angles = 2 * pi / points + angle;
    var path = Path();

    if (angles > 2 * pi) angles = 0;

    for (var i = 1; i <= points; i++) {
      vertices.add(Offset(
        pos.dx + cos(angles * i) * radius,
        pos.dy + sin(angles * i) * radius,
      ));
    }
    // vertices.add(Offset(pos.dx + radius, pos.dy));

    path.addPolygon(vertices, true);

    c.drawPath(path, paint);

    // c.drawRect(
    //     Rect.fromLTWH(pos.dx, pos.dy, 1, 1), Paint()..color = Colors.black);
  }
}
