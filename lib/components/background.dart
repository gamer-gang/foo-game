import 'dart:ui';

import 'package:flutter/painting.dart';

import '../game.dart';
import 'component.dart';

class Background extends GameObject {
  MonumentPlatformer game;
  Color color;
  Paint paint;

  Background({
    this.game, 
    Color initialColor,
  }) {
    paint = Paint()..color = initialColor;
    color = initialColor;
  }

  void render(Canvas c) {
    Paint paint = Paint()..color = color;

    c.drawRect(Rect.fromLTWH(0, 0, game.viewport.width, game.viewport.height), paint);
  }
  
  void update(double t) {

  }


  void updatePosition(Offset playerPos) {
    if (playerPos.dx < 50)
      paint.color = Color(0xffffffff);
    else if (playerPos.dx < 100) 
      paint.color = Color(0xffcccccc);
    else if (playerPos.dx < 150) 
      paint.color = Color(0xff999999);
    else if (playerPos.dx < 200) 
      paint.color = Color(0xff444444);
    else 
      paint.color = Color(0xff111111);
    
    // LinearGradient gradient = LinearGradient(
    //   colors: [
    //     Color(0xffffffff),
    //     Color(0xff000000)
    //   ]
    // );  

    // paint.shader = gradient.createShader(Rect.fromLTWH(0, 0, game.viewport.width, game.viewport.height));
  }
}