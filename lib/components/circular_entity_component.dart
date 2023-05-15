import 'dart:math';

import 'entity_component.dart';

class CircularEntityComponent extends EntityComponent {
  CircularEntityComponent({
    super.position,
    super.size,
    super.hue,
    super.saturation,
    super.brightness,
    required this.radius,
    required this.omega,
  }) : super();

  final double radius;
  final double omega;

  var theta = 0.0;

  @override
  void updateEntity(double dt) {
    super.updateEntity(dt);

    vx = radius * cos(theta);
    vy = radius * sin(theta);
    theta += omega * dt;
  }
}
