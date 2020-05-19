import 'package:flutter/painting.dart';

import '../game.dart';
import 'component.dart';
import 'platform.dart';

class Level extends GameObject {
  Map<Layers, List<GameObject>> layers;
  List<GameObject> background;
  List<GameObject> middleground;
  List<GameObject> foreground;
  List<GameObject> ui;

  double voidHeight;
  Platform voidPlatform;

  Level.create({
    MonumentPlatformer game,
    this.foreground,
    this.voidHeight = 300,
  }) : super.create(game) {
    foreground.forEach((el) => this.addChild(el));

    voidPlatform = Platform.create(
      game: game,
      color: Color(0x00000000),
      initialPosition: Offset(0, voidHeight),
      size: Offset(100, double.infinity),
      canKillPlayer: true,
    );

    layers = {
      Layers.background: background,
      Layers.middleground: middleground,
      Layers.foreground: foreground,
      Layers.ui: ui
    };
  }

  render(c) {
    super.render(c);
  }

  void add(Layers layer, object) {
    
    layers = {
      Layers.background: background,
      Layers.middleground: middleground,
      Layers.foreground: foreground,
      Layers.ui: ui
    };
  }
}
