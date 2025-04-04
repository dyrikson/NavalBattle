import 'package:flutter/material.dart';
import 'package:nv/BackEnd/Game.dart';
import 'package:nv/BackEnd/Fire.dart';
import 'package:nv/BackEnd/Ships.dart';
import 'package:nv/FrontEnd/Field_and_FridCell.dart';

class GameBackGround extends StatelessWidget {
  const GameBackGround({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/BattleShip.jpg"), fit: BoxFit.cover)),
          child: const GameScreen(),
        )
    );
  }
}
class GameScreen extends StatefulWidget{
  const GameScreen({super.key});
  @override
  _GameScreen createState() => _GameScreen();
}
class _GameScreen extends State<GameScreen> {
  late Game game;
  int gridSize = 10;
  GameResult? gameResult;
  @override
  void initState() {
    super.initState();
    _initializeGame();
  }
  void _initializeGame() {
    game = Game(Fire(), Ships());
    game.onUpdate.listen((_) => setState(() {}));
    game.onGameOver.listen((result) {
      setState(() {
        gameResult = result;
      });
    });
  }
  void _restartGame() {
    setState(() {
      gameResult = null;
      _initializeGame();
    });
  }
  @override
  Widget build(BuildContext context) {
    if (gameResult != null) {
      return _buildGameOverScreen();
    }
    return _buildGameScreen();
  }
  Widget _buildGameOverScreen() {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              gameResult == GameResult.playerWin ? 'Поражение!' : 'Победа!',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _restartGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text(
                'Играть снова',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildGameScreen() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double availableWidth = constraints.maxWidth - 250;
        double cellSize = availableWidth / (gridSize * 2);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const DefaultTextStyle(
                        style: TextStyle(color: Colors.black, fontSize: 40),
                        child: Text("Поле игрока"),
                      ),
                      Container(
                        width: cellSize * gridSize,
                        height: cellSize * gridSize,
                        color: Colors.black26.withOpacity(0.5),
                        child: Field(
                          gridSize: 10,
                          cellSize: cellSize,
                          playerRecognition: true,
                          board: game.ships.shipsEnemy,
                          onCellTap: (index) {
                            game.sendPlayerShot(index, true);
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const DefaultTextStyle(
                        style: TextStyle(color: Colors.black, fontSize: 40),
                        child: Text("Поле противника"),
                      ),
                      Container(
                        width: cellSize * gridSize,
                        height: cellSize * gridSize,
                        color: Colors.black26.withOpacity(0.5),
                        child: Field(
                          gridSize: 10,
                          cellSize: cellSize,
                          playerRecognition: false,
                          board: game.ships.ships,
                          onCellTap: (index) {
                            game.sendPlayerShot(index, false);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
