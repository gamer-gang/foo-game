import 'package:monument_platformer/components/component.dart';
import 'package:monument_platformer/components/platform.dart';
import 'package:monument_platformer/game.dart';

class Level extends GameObject {
  MonumentPlatformer game;
  List<Platform> platforms;

  Level({this.game, this.platforms}) {
    platforms.forEach((el) => this.addChild(el));
  }

  render(c) {
    super.render(c);
  }
}
