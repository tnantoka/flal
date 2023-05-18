import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'creature.dart';
import 'food.dart';

class MainGame extends FlameGame {
  MainGame({required this.initialCreatures, required this.initialFoods})
      : super();

  final int initialCreatures;
  final int initialFoods;
  final random = Random();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    await add(
      FpsTextComponent(),
    );

    for (var i = 0; i < initialCreatures; i++) {
      final position = Vector2(
        random.nextDouble() * size.x,
        random.nextDouble() * size.y,
      );

      await add(
        Creature(
          position: position,
        ),
      );
    }

    for (var i = 0; i < initialFoods; i++) {
      final position = Vector2(
        random.nextDouble() * size.x,
        random.nextDouble() * size.y,
      );

      await add(
        Food(
          position: position,
        ),
      );
    }
  }
}
