import 'dart:math';

import 'entity_component.dart';

class ScalingEntityComponent extends EntityComponent {
  ScalingEntityComponent({
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

    vw = vh = radius * cos(theta);
    theta += omega * dt;
  }
}
