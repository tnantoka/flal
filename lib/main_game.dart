import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'components/entity_component.dart';
import 'components/circular_entity_component.dart';
import 'components/scaling_entity_component.dart';

class MainGame extends FlameGame {
  MainGame({required this.initialEntities}) : super();

  final int initialEntities;
  final random = Random();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    await add(
      FpsTextComponent(),
    );

    for (var i = 0; i < initialEntities; i++) {
      final size = Vector2(
        50 + random.nextDouble() * 100,
        50 + random.nextDouble() * 100,
      );
      final position = Vector2(
        size.x * 0.5 + random.nextDouble() * (this.size.x - size.x),
        size.y * 0.5 + random.nextDouble() * (this.size.y - size.y),
      );
      final hue = random.nextDouble() * 360;
      final radius = 10 + random.nextDouble() * 20;
      final omega = 5 + random.nextDouble() * 5;

      EntityComponent entity;
      switch (random.nextInt(3)) {
        case 0:
          entity = CircularEntityComponent(
            position: position,
            size: size,
            hue: hue,
            radius: radius,
            omega: omega,
          );
          break;
        case 1:
          entity = ScalingEntityComponent(
            position: position,
            size: size,
            hue: hue,
            radius: radius,
            omega: omega,
          );
          break;
        default:
          entity = EntityComponent(
            position: position,
            size: size,
            hue: hue,
          );
          break;
      }
      await add(entity);
    }
  }
}
