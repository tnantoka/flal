import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'components/entity_component.dart';
import 'components/circular_entity_component.dart';
import 'components/scaling_entity_component.dart';

class MainGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    super.onLoad();

    await add(
      FpsTextComponent(),
    );

    await add(
      EntityComponent(
        position: Vector2(
          size.x * 0.5,
          size.y * 0.5,
        ),
        size: Vector2(
          100,
          100,
        ),
      ),
    );

    await add(
      CircularEntityComponent(
        position: Vector2(
          size.x * 0.5,
          size.y * 0.5,
        ),
        size: Vector2(
          100,
          100,
        ),
        radius: 30,
        omega: 10,
      ),
    );

    await add(
      ScalingEntityComponent(
        position: Vector2(
          size.x * 0.5,
          size.y * 0.5,
        ),
        size: Vector2(
          100,
          100,
        ),
        radius: 30,
        omega: 10,
      ),
    );
  }
}
