import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'creature.dart';
import 'food.dart';

class MainGame extends FlameGame with HasCollisionDetection {
  MainGame({
    required this.initialCreaturesA,
    required this.initialCreaturesB,
    required this.initialFoods,
  }) : super();

  final int initialCreaturesA;
  final int initialCreaturesB;
  final int initialFoods;
  final random = Random();
  late final TextBoxComponent infoText;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // debugMode = true;
    // await add(
    //   FpsTextComponent(),
    // );

    infoText = TextBoxComponent(
      text: info(),
      priority: 3,
    );
    await add(infoText);

    for (var i = 0; i < initialCreaturesA; i++) {
      addCreature(CreatureType.a);
    }

    for (var i = 0; i < initialCreaturesB; i++) {
      addCreature(CreatureType.b);
    }

    for (var i = 0; i < initialFoods; i++) {
      addFood();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    infoText.text = info();
  }

  String info() {
    return '''Creatures A: ${children.whereType<Creature>().where((c) => c.type == CreatureType.a).length}
Creatures B: ${children.whereType<Creature>().where((c) => c.type == CreatureType.b).length}
Foods: ${children.whereType<Food>().length}''';
  }

  addCreature(CreatureType type) {
    if (children.whereType<Creature>().length > 100) {
      return;
    }

    final position = Vector2(
      random.nextDouble() * size.x,
      random.nextDouble() * size.y,
    );

    add(
      Creature(
        position: position,
        type: type,
        sex: random.nextBool() ? CreatureSex.m : CreatureSex.f,
      ),
    );
  }

  addFood() {
    final position = Vector2(
      random.nextDouble() * size.x,
      random.nextDouble() * size.y,
    );

    add(
      Food(
        position: position,
      ),
    );
  }
}
