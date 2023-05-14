import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

class MainGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    super.onLoad();

    await add(
      FpsTextComponent(),
    );
  }
}
