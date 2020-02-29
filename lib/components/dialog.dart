import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../game.dart';
import 'core/gameobject.dart';
import 'text.dart';

class Dialog extends GameObject {
  final MonumentPlatformerGame game;
  Paint paint;
  Rect wrapper;
  RRect wrapperBox;
  Rect playButton;
  RRect playButtonBox;
  TextComponent titleText;
  TextComponent scoreText;
  TextComponent buttonText;

  Dialog({this.game}) : super(game) {
    double paddingX = 0.1;
    double paddingY = 0.25;

    double rectLeft = game.viewport.width * paddingX;
    double rectTop = game.viewport.height * paddingY;
    double rectWidth = game.viewport.width * (1 - paddingX * 2);
    double rectHeight = game.viewport.height * (1 - paddingY * 2);

    wrapper = Rect.fromLTWH(rectLeft, rectTop, rectWidth, rectHeight);
    wrapperBox = RRect.fromRectAndRadius(wrapper, Radius.circular(4));

    double buttonWidth = 150;
    double buttonHeight = buttonWidth / 2;
    double padding = 32;

    playButton = Rect.fromLTWH((game.viewport.width / 2) - buttonWidth / 2,
        wrapper.center.dy - 12.5, buttonWidth, buttonHeight);
    playButtonBox = RRect.fromRectAndRadius(playButton, Radius.circular(4));

    paint = Paint();

    titleText = TextComponent(
      game: game,
      text: 'Game Over!',
      fontSize: 45.0,
      y: rectTop + padding,
      colorCode: 0xff3D4852,
    );
    scoreText = TextComponent(
      game: game,
      text: '',
      fontSize: 30.0,
      y: playButton.top - padding / 2,
      colorCode: 0xff606F7B,
    );

    buttonText = TextComponent(
      game: game,
      text: 'Play again',
      fontSize: 25.0,
      y: playButton.center.dy,
      colorCode: 0xfffafafa,
    );
    

    children.add(titleText);
    children.add(scoreText);
    children.add(buttonText);
  }

  @override
  void render(Canvas c) {
    paint.color = Color(0xd9EDF2F7);
    c.drawRRect(wrapperBox, paint);
    paint.color = Color(0xffEF5753);
    c.drawRRect(playButtonBox, paint);
    super.render(c);
  }

  @override
  void update(double t) {
    scoreText.setText('Score: ${game.currentHeight.floor().toString()}');
    super.update(t);
  }
}