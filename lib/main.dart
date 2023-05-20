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
  var initialLifeController = TextEditingController(text: '1000');
  var maxAgeController = TextEditingController(text: '1000');
  var foodRatioController = TextEditingController(text: '0.1');
  var battleRatioController = TextEditingController(text: '0.1');
  var reproductionRateController = TextEditingController(text: '0.1');

  var game = MainGame(
    initialCreaturesA: 20,
    initialCreaturesB: 20,
    initialFoods: 100,
    initialLife: 1000,
    maxAge: 1000,
    foodRatio: 0.1,
    battleRatio: 0.1,
    reproductionRate: 0.1,
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
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: initialCreaturesAController,
                          decoration: const InputDecoration(
                            labelText: 'Creatures A',
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: initialCreaturesBController,
                          decoration: const InputDecoration(
                            labelText: 'Creatures B',
                          ),
                        ),
                      ),
                    ],
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
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: initialLifeController,
                          decoration: const InputDecoration(
                            labelText: 'Initial Life',
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: maxAgeController,
                          decoration: const InputDecoration(
                            labelText: 'Max Age',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: foodRatioController,
                          decoration: const InputDecoration(
                            labelText: 'Food Ratio',
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: battleRatioController,
                          decoration: const InputDecoration(
                            labelText: 'Battle Ratio',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: reproductionRateController,
                    decoration: const InputDecoration(
                      labelText: 'Reproduction Ratio',
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
        initialLife: int.parse(
          initialLifeController.text,
        ),
        maxAge: int.parse(
          maxAgeController.text,
        ),
        foodRatio: double.parse(
          foodRatioController.text,
        ),
        battleRatio: double.parse(
          battleRatioController.text,
        ),
        reproductionRate: double.parse(
          reproductionRateController.text,
        ),
      );
    });
  }
}
