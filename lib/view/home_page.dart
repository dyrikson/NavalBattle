import 'package:flutter/material.dart';
import 'package:nv/domain/game.dart';
import 'package:nv/domain/models/field.dart';
import 'package:nv/domain/models/shoot_result.dart';
import 'package:nv/view/field_widget.dart';
///
/// The home page of the Game
class HomePage extends StatefulWidget {
  final Size size;
  ///
  /// The home page of the Game
  const HomePage({
    super.key,
    this.size = const Size(10, 10),
  });
  //
  //
  @override
  State<HomePage> createState() => _HomePage();
}
//
//
class _HomePage extends State<HomePage> {
  ShootResult _status = ShootResult.miss;
  late Game _game;
  int _index = 0;
  // //
  // // Handles player's move
  // // [position] - Grid position of the move
  // // [playerRecognition] - Flag indicating who made the move (player/enemy)
  // void _handlePlayerMove(int position, bool playerRecognition) {
  //   setState(() {
  //     _game.gameTurn(position, playerRecognition);
  //     gameStatus = _game.status;
  //   });
  // }
  //
  //
  @override
  void initState() {
    _game = Game([
      Field.user(10, 10, 10),
      Field.comp(10, 10, 10),
    ]);
    super.initState();
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
    // if (_status == ShootResult.win) {
    //   return EndGamePage(
    //     gameResult: gameStatus,
    //     onRestart: _restartGame,
    //   );
    // }
    return _homePage();
  }
  /// Builds the main game interface with two battlefields
  Widget _homePage() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double availableWidth = constraints.maxWidth - 250;
        double cellSize = availableWidth / (widget.size.width * widget.size.height);
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
                        width: cellSize * widget.size.width,
                        height: cellSize * widget.size.height,
                        color: Colors.black26.withValues(alpha: 0.5),
                        child: FieldWidget(
                          size: widget.size,
                          cellSize: cellSize,
                          cells: _game.cells(0),
                          onTap: (x, y) {
                            final (result, index) = _game.shoot(x, y);
                            setState(() {
                              _index = index;
                            });
                            return result;
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
                        width: cellSize * widget.size.width,
                        height: cellSize * widget.size.height,
                        color: Colors.black26.withValues(alpha: 0.5),
                        child: FieldWidget(
                          size: widget.size,
                          cellSize: cellSize,
                          cells: _game.cells(0),
                          onTap: (x, y) {
                            final (result, index) = _game.shoot(x, y);
                            setState(() {
                              _index = index;
                            });
                            return result;
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
