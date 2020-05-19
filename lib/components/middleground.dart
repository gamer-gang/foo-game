import 'dart:ui';

import 'package:flutter/painting.dart';

import '../game.dart';
import 'component.dart';

class Middleground extends GameObject {
  List objects;

  Middleground.create({
    MonumentPlatformer game,
    this.objects
  }) : super.create(game) {
    objects = [];
  }
  
  void update(double t) {

  }

  void render(Canvas c) {

  }
}
