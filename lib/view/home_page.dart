import 'package:flutter/material.dart';
import 'package:nv/domain/game.dart';
import 'package:nv/domain/fire.dart';
import 'package:nv/domain/game_result.dart';
import 'package:nv/domain/ships.dart';
import 'package:nv/view/field.dart';

///
/// The home page of the Game
class HomePage extends StatefulWidget{
  ///
  /// The home page of the Game
  const HomePage({super.key});
  //
  @override
  _GameScreen createState() => _GameScreen();
}
//
//
class _GameScreen extends State<HomePage> {
  late Game _game;
  int gridSize = 10;
  GameResult? _gameResult;
  //
  @override
  void initState() {
    super.initState();
    _initializeGame();
  }
  //
  void _initializeGame() {
    _game = Game(
      Fire(),
      Ships()
    );
    _game.onUpdate.listen((_) => setState(() {}));
    _game.onGameOver.listen((result) {
      setState(() {
        _gameResult = result;
      });
    });
  }
  //
  //
  void _restartGame() {
    setState(() {
      _gameResult = null;
      _initializeGame();
    });
  }
  //
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 0.7),
      body: (_gameResult != null)
        ? _buildGameOverScreen()
        : _buildGameScreen(),
    );
  }
  ///
  ///
  Widget _buildGameOverScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _gameResult == GameResult.playerWin ? 'Поражение!' : 'Победа!',
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
                        color: Colors.black26.withValues(alpha: 0.5),
                        child: Field(
                          gridSize: 10,
                          cellSize: cellSize,
                          playerRecognition: true,
                          board: _game.ships.shipsEnemy,
                          onCellTap: (index) {
                            _game.sendPlayerShot(index, true);
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
                        color: Colors.black26.withValues(alpha: 0.5),
                        child: Field(
                          gridSize: 10,
                          cellSize: cellSize,
                          playerRecognition: false,
                          board: _game.ships.ships,
                          onCellTap: (index) {
                            _game.sendPlayerShot(index, false);
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
