import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class EntityComponent extends PositionComponent {
  EntityComponent({
    super.position,
    super.size,
    this.hue = 0.0,
    this.saturation = 0.0,
    this.brightness = 1.0,
  }) : super();

  final double hue;
  final double saturation;
  final double brightness;

  var vx = 0.0;
  var vy = 0.0;
  var vw = 0.0;
  var vh = 0.0;
  var alive = true;

  @override
  void update(double dt) {
    super.update(dt);

    if (alive) {
      updateEntity(dt);
    }
  }

  void updateEntity(double dt) {}

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint = Paint()
      ..color = HSVColor.fromAHSV(1.0, hue, saturation, brightness).toColor()
      ..style = PaintingStyle.stroke;

    final w = width + vw;
    final h = height + vh;
    canvas.drawRect(
      Rect.fromLTWH(
        -w * 0.5 + vx,
        -h * 0.5 + vy,
        w,
        h,
      ),
      paint,
    );
  }
}
