import 'package:flutter/material.dart';
import 'package:nv/domain/game.dart';
import 'package:nv/domain/services/shooting_service.dart';
import 'package:nv/domain/models/game_status.dart';
import 'package:nv/domain/models/ships.dart';
import 'package:nv/view/field_widget.dart';
import 'package:nv/view/endgame_page.dart';
///
/// The home page of the Game
class HomePage extends StatefulWidget {
  ///
  /// The home page of the Game
  const HomePage({super.key});
  @override
  _HomePage createState() => _HomePage();
}
class _HomePage extends State<HomePage> {
  late Game _game;
  late final int _gridSize;
  GameStatus? gameStatus;
  //
  // Initializes the main page state
  // [_gridSize] - Size of the game grid (default 10x10)
  _HomePage() {
    _gridSize = 10;
  }
  //
  // Handles player's move
  // [position] - Grid position of the move
  // [playerRecognition] - Flag indicating who made the move (player/enemy)
  void _handlePlayerMove(int position, bool playerRecognition) {
    setState(() {
      _game.gameTurn(position, playerRecognition);
      gameStatus = _game.status;
    });
  }
  @override
  void initState() {
    super.initState();
    _initializeGame();
  }
  //
  // Initializes a new game with empty boards
  void _initializeGame() {
    _game = Game(Fire(), Ships());
  }
  //
  // Restarts the game by resetting all states
  void _restartGame() {
    setState(() {
      initState();
    });
  }
  /// Builds a widget that implements a transition to the end game page.
  @override
  Widget build(BuildContext context) {
    if (gameStatus == GameStatus.playerLose ||
        gameStatus == GameStatus.playerWin) {
      return EndGamePage(
        gameResult: gameStatus,
        onRestart: _restartGame,
      );
    }
    return _homePage();
  }
  /// Builds the main game interface with two battlefields
  Widget _homePage() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double availableWidth = constraints.maxWidth - 250;
        double cellSize = availableWidth / (_gridSize * 2);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Player's battlefield
                  Column(
                    children: [
                      const DefaultTextStyle(
                        style: TextStyle(color: Colors.black, fontSize: 40),
                        child: Text("Player Field"),
                      ),
                      Container(
                        width: cellSize * _gridSize,
                        height: cellSize * _gridSize,
                        color: Colors.black26.withOpacity(0.5),
                        child: Field(
                          gridSize: 10,
                          cellSize: cellSize,
                          playerRecognition: true,
                          board: _game.ships.shipsEnemy,
                          onCellTap: (index) {
                            _handlePlayerMove(index, true);
                          },
                        ),
                      ),
                    ],
                  ),
                  // Enemy's battlefield
                  Column(
                    children: [
                      const DefaultTextStyle(
                        style: TextStyle(color: Colors.black, fontSize: 40),
                        child: Text("Enemy Field"),
                      ),
                      Container(
                        width: cellSize * _gridSize,
                        height: cellSize * _gridSize,
                        color: Colors.black26.withOpacity(0.5),
                        child: Field(
                          gridSize: 10,
                          cellSize: cellSize,
                          playerRecognition: false,
                          board: _game.ships.ships,
                          onCellTap: (index) {
                            _handlePlayerMove(index, false);
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