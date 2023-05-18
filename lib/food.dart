import 'package:flame/components.dart';
import 'package:flame/palette.dart';

class Food extends RectangleComponent {
  Food({
    super.position,
  }) : super(size: Vector2(10, 10), paint: BasicPalette.yellow.paint());
}
