import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainGame extends Game {
  bool up, dash, left, right;

  updateControls({
    upPressed: false,
    dashPressed: false,
    leftPressed: false,
    rightPressed: false,
  }) {
    up = upPressed;
    dash = dashPressed;
    left = leftPressed;
    right = rightPressed;
  }

  MainGame() {
    initialize();
  }

  // Initialize all things we need, devided by things need the size and things without
  Future initialize() async {
    // Call the resize as soon as flutter is ready
    resize(await Flame.util.initialDimensions());
  }

  Paint paint;

  // Size of the screen from the resize event
  Size viewport;

  @override
  void resize(Size size) {
    paint = Paint();
    paint.color = Color.fromARGB(255, 255, 255, 255);
    //Store size and related rectangle
    viewport = size;
    super.resize(size);
  }

  void render(Canvas c) {

  }

  @override
  void update(double t) {}
}
