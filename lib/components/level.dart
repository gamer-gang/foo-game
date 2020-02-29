import 'dart:math';

import '../game.dart';
import 'obstacle.dart';

class Level {
  final MonumentPlatformerGame game;
  List<Obstacle> levelObstacles;
  final Random rng = new Random();

  Level({this.game}) {
    generateObstacles();
  }

  void generateObstacles() {
    levelObstacles = List<Obstacle>();
    Obstacle obstacle;
    double obstacleWidth;
    double obstacleHeight;
    double posX;
    double posY;
    for (int i = 2; i < 200; i++) {
      bool isLeft = rng.nextBool();
      bool isMoving = false;
      int movingRng = rng.nextInt(5);

      if (movingRng == 4) {
        obstacleWidth = (rng.nextDouble() * (game.viewport.width * 0.2)) +
            (game.viewport.width * 0.3);
        obstacleHeight = game.viewport.height / game.tileSize * 6;
        isLeft = true;
        isMoving = true;
      } else {
        obstacleWidth =
            (rng.nextDouble() * game.tileSize / 4) + game.viewport.width / 40;
        obstacleHeight =
            (rng.nextDouble() * game.tileSize * 6) + game.viewport.height / 10;
      }
      // Position Obstacles
      posY = ((-i * 300) + game.viewport.height);
      if (isLeft) {
        posX = 0;
      } else {
        posX = game.viewport.width - obstacleWidth;
      }
      obstacle = Obstacle(
        game: game,
        x: posX,
        y: posY,
        width: obstacleWidth,
        height: obstacleHeight,
        isMoving: isMoving,
      );
      // Add obstacles to level
      levelObstacles.add(obstacle);
    }
  }
}