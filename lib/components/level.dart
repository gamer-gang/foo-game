import 'dart:math';

import '../game.dart';
import 'platform.dart';

class Level {
  final MonumentPlatformerGame game;
  List<Platform> levelPlatforms;
  final Random rng = new Random();

  Level({this.game}) {
    generatePlatforms();
  }

  void generatePlatforms() {
    levelPlatforms = List<Platform>();
    Platform platform;
    double platformWidth;
    double platformHeight;
    double posX;
    double posY;
    for (int i = 2; i < 200; i++) {
      bool isLeft = rng.nextBool();
      bool isMoving = false;
      int movingRng = rng.nextInt(5);

      if (movingRng == 4) {
        platformWidth = (rng.nextDouble() * (game.viewport.width * 0.2)) +
            (game.viewport.width * 0.3);
        platformHeight = game.viewport.height / game.tileSize * 2;
        isLeft = true;
        isMoving = true;
      } else {
        platformWidth =
            (rng.nextDouble() * game.tileSize / 4) + game.viewport.width / 40;
        platformHeight =
            (rng.nextDouble() * game.tileSize * 2) + game.viewport.height / 10;
      }
      // Position Obstacles
      posY = ((-i * 300) + game.viewport.height);
      if (isLeft) {
        posX = 0;
      } else {
        posX = game.viewport.width - platformWidth;
      }
      platform = Platform(
        game: game,
        x: posX,
        y: posY,
        width: platformWidth,
        height: platformHeight,
        isMoving: isMoving,
      );
      // Add obstacles to level
      levelPlatforms.add(platform);
    }
  }
}
