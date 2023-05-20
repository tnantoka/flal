import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

import 'food.dart';
import 'main_game.dart';

enum CreatureType {
  a,
  b,
}

enum CreatureSex {
  m,
  f,
}

class Creature extends PositionComponent
    with CollisionCallbacks, HasGameRef<MainGame> {
  Creature({
    super.position,
    required this.type,
    required this.sex,
    required this.initialLife,
    required this.maxAge,
    required this.foodRatio,
    required this.battleRatio,
    required this.reproductionRate,
  }) : super(size: Vector2(50, 50), priority: 2) {
    life = initialLife;
  }

  final random = Random();
  final int maxAge;
  final speed = 100.0;
  final double reproductionRate;
  final CreatureType type;
  final CreatureSex sex;
  final double foodRatio;
  final double battleRatio;

  var age = 0;
  final int initialLife;
  var life = 0;
  var elapsed = 0.0;

  var velocity = Vector2.zero();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    await add(
      RectangleHitbox(
        anchor: Anchor.center,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    elapsed += dt;

    position.add(velocity * dt);
    if (elapsed > 0.1) {
      velocity = Vector2(
        random.nextDouble() * speed * (random.nextBool() ? 1 : -1),
        random.nextDouble() * speed * (random.nextBool() ? 1 : -1),
      );
      elapsed = 0;
    }

    if (life > 0) {
      age++;
      life--;
      if (life == 0 || age >= maxAge) {
        add(RemoveEffect(delay: 0.3));
      }
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final ageRect = Rect.fromCenter(
      center: Offset.zero,
      width: width,
      height: height,
    );

    canvas.drawRect(
      ageRect,
      BasicPalette.black.paint(),
    );

    canvas.drawRect(
      ageRect,
      Paint()
        ..color = Colors.grey.withOpacity(
          1 - min(1, age * 0.001),
        ),
    );

    final border = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRect(
      Rect.fromLTWH(
        -width * 0.5,
        -height * 0.5,
        width,
        height * 0.8,
      ),
      border,
    );

    if (type == CreatureType.a) {
      canvas.drawLine(
        Offset(-width * 0.5, -height * 0.5),
        Offset(width * 0.5, height * 0.3),
        border,
      );
      canvas.drawLine(
        Offset(width * 0.5, -height * 0.5),
        Offset(-width * 0.5, height * 0.3),
        border,
      );
    } else {
      canvas.drawLine(
        Offset(0, -height * 0.5),
        Offset(0, height * 0.3),
        border,
      );
      canvas.drawLine(
        Offset(width * 0.5, -height * 0.1),
        Offset(-width * 0.5, -height * 0.1),
        border,
      );
    }

    final lifeRect = Rect.fromLTWH(
      -width * 0.5,
      height * 0.3,
      width,
      height * 0.2,
    );

    canvas.drawRect(
      lifeRect,
      BasicPalette.red.paint(),
    );
    canvas.drawRect(
      Rect.fromLTWH(
        lifeRect.left,
        lifeRect.top,
        lifeRect.width / initialLife * life,
        lifeRect.height,
      ),
      BasicPalette.green.paint(),
    );
    canvas.drawRect(
      lifeRect,
      border,
    );
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Creature) {
      if (other.type != type) {
        subLife(battleRatio);
      }

      if (other.type == type &&
          other.sex != sex &&
          other.isReproductive() &&
          isReproductive()) {
        game.addCreature(type);
      }
    } else if (other is Food) {
      addLife(foodRatio);
      game.addFood();
      other.removeFromParent();
    }
  }

  addLife(double ratio) {
    life = min(initialLife, life + (initialLife.toDouble() * ratio).toInt());
  }

  subLife(double ratio) {
    if (life <= initialLife * ratio) {
      return;
    }

    life = life - (initialLife.toDouble() * ratio).toInt();
  }

  bool isReproductive() {
    return age > maxAge * 0.1 &&
        life > initialLife * 0.5 &&
        random.nextDouble() < reproductionRate;
  }
}
