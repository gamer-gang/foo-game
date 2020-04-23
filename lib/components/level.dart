import 'package:flutter/painting.dart';

import '../game.dart';
import 'component.dart';
import 'platform.dart';

class Level extends GameObject {
  List<Platform> platforms;

  double voidHeight;
  Platform voidPlatform;

  Level.create({
    MonumentPlatformer game,
    this.platforms,
    this.voidHeight = 300,
  }) : super.create(game) {
    platforms.forEach((el) => this.addChild(el));
    voidPlatform = Platform.create(
      game: game,
      color: Color(0x00000000),
      initialPosition: Offset(0, voidHeight),
      size: Offset(100, double.infinity),
      canKillPlayer: true,
    );
  }

  render(c) {
    super.render(c);
  }
}
