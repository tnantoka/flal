import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Creature extends PositionComponent {
  Creature({
    super.position,
  }) : super(size: Vector2(50, 50));

  var initialLife = 100;
  var life = 100;
  var age = 0;
  final maxAge = 100;

  @override
  void update(double dt) {
    super.update(dt);

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

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(
          0,
          -height * 0.1,
        ),
        width: width / maxAge * age,
        height: height * 0.8 / maxAge * age,
      ),
      BasicPalette.gray.paint(),
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
}
