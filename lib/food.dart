import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';

import 'main_game.dart';
import 'creature.dart';

class Food extends RectangleComponent
    with CollisionCallbacks, HasGameRef<MainGame> {
  Food({
    super.position,
  }) : super(
            size: Vector2(10, 10),
            anchor: Anchor.center,
            paint: BasicPalette.yellow.paint());

  @override
  Future<void> onLoad() async {
    super.onLoad();

    await add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Creature) {
      other.addLife(0.1);
      game.addFood();
      removeFromParent();
    }
  }
}
