import 'package:flutter/painting.dart';

import '../game.dart';
import 'gameobject.dart';
import 'platform.dart';

enum Layers { background, middleground, foreground, ui }

class Level extends GameObject {
  Map<Layers, List<GameObject>> layers;
  double voidHeight;
  Platform voidPlatform;

  Level.create({
    MonumentPlatformer game,
    this.layers,
    this.voidHeight = 100,
  }) : super.create(game) {
    voidPlatform = Platform.create(
      game: game,
      color: Color(0x00000000),
      pos: Offset(-1000000, voidHeight),
      size: Offset(2000000, 100),
      canKillPlayer: true,
      collide: true,
    );

    // add empty layers if not there
    for (var layer in Layers.values) {
      layers.putIfAbsent(layer, () => []);
    }

    foreground.add(voidPlatform);
  }

  void render(Canvas c) {}

  /// Alias for `layers[Layers.background]`
  List<GameObject> get background => layers[Layers.background];

  /// Alias for `layers[Layers.middleground]`
  List<GameObject> get middleground => layers[Layers.middleground];

  /// Alias for `layers[Layers.foreground]`
  List<GameObject> get foreground => layers[Layers.foreground];

  /// Alias for `layers[Layers.ui]`
  List<GameObject> get ui => layers[Layers.ui];

  /// Add a GameObject to the given layer.
  void add(Layers layer, GameObject object) => layers[layer].add(object);

  void _renderAll(List<GameObject> objects, Canvas c) {
    for (var object in objects) {
      object.render(c);
    }
  }

  void _updateAll(List<GameObject> objects, double t) {
    for (var objectIndex = 0; objectIndex < objects.length; objectIndex++) {
      objects[objectIndex].update(t);
    }
  }

  /// Render each GameObject in the layer.
  void renderBackground(Canvas c) => _renderAll(background, c);

  /// Render each GameObject in the layer.
  void renderMiddleground(Canvas c) => _renderAll(middleground, c);

  /// Render each GameObject in the layer.
  void renderForeground(Canvas c) => _renderAll(foreground, c);

  /// Render each GameObject in the layer.
  void renderUi(Canvas c) => _renderAll(ui, c);

  /// Update each GameObject in the layer.
  void updateBackground(double t) => _updateAll(background, t);

  /// Update each GameObject in the layer.
  void updateMiddleground(double t) => _updateAll(middleground, t);

  /// Update each GameObject in the layer.
  void updateForeground(double t) => _updateAll(foreground, t);

  /// Update each GameObject in the layer.
  void updateUi(double t) => _updateAll(ui, t);
}
