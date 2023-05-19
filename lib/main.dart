import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var initialCreaturesController = TextEditingController(text: '5');
  var initialFoodsController = TextEditingController(text: '100');

  var game = MainGame(initialCreatures: 5, initialFoods: 100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flal'),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: ClipRect(
              child: GameWidget(game: game),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: initialCreaturesController,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: initialFoodsController,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _updateGame(),
                    child: const Text('Run'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _updateGame() {
    setState(() {
      game = MainGame(
        initialCreatures: int.parse(
          initialCreaturesController.text,
        ),
        initialFoods: int.parse(
          initialFoodsController.text,
        ),
      );
    });
  }
}
