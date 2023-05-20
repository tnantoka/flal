import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';

class Food extends RectangleComponent with CollisionCallbacks {
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
}
