import '../game.dart';
import 'component.dart';
import 'platform.dart';

class Level extends GameObject {
  List<Platform> platforms;

  Level.create({MonumentPlatformer game, this.platforms}) : super.create(game) {
    platforms.forEach((el) => this.addChild(el));
  }

  render(c) {
    super.render(c);
  }
}
