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
  var initialCreaturesAController = TextEditingController(text: '20');
  var initialCreaturesBController = TextEditingController(text: '20');
  var initialFoodsController = TextEditingController(text: '100');

  var game = MainGame(
    initialCreaturesA: 20,
    initialCreaturesB: 20,
    initialFoods: 100,
  );

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
                    controller: initialCreaturesAController,
                    decoration: const InputDecoration(
                      labelText: 'Creatures A',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: initialCreaturesBController,
                    decoration: const InputDecoration(
                      labelText: 'Creatures B',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: initialFoodsController,
                    decoration: const InputDecoration(
                      labelText: 'Foods',
                    ),
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
        initialCreaturesA: int.parse(
          initialCreaturesAController.text,
        ),
        initialCreaturesB: int.parse(
          initialCreaturesBController.text,
        ),
        initialFoods: int.parse(
          initialFoodsController.text,
        ),
      );
    });
  }
}
