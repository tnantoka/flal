import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Creature extends PositionComponent {
  Creature({
    super.position,
  }) : super(size: Vector2(50, 50), priority: 2);

  final random = Random();
  final maxAge = 100;
  final speed = 100.0;

  var age = 0;
  var initialLife = 1000;
  var life = 1000;
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
      if (life == 0) {
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
          1 - min(1, age * 0.004),
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

  addLife(double ratio) {
    life = min(initialLife, life + (initialLife.toDouble() * ratio).toInt());
  }
}
