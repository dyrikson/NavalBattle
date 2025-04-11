import 'package:flutter/material.dart';
import 'package:nv/domain/game.dart';
import 'package:nv/domain/models/field.dart';
import 'package:nv/domain/models/shoot_result.dart';
import 'package:nv/view/endgame_page.dart';
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
  late Game _game;
  GameState _state = GameState.end;
  int _index = 0;
  bool _win = false;
  //
  //
  @override
  void initState() {
    _newGame();
    super.initState();
  }
  ///
  ///
  _newGame() {
    _index = 0;
    _state = GameState.game;
    _win = false;
    _game = Game([
      Field.user(10, 10, 10),
      Field.comp(10, 10, 10),
    ]);
  }
  //
  //
  @override
  Widget build(BuildContext context) {
    return _state == GameState.end
    ? EndGamePage(
      win: _win,
      onDone: () {
        _newGame();
        setState(() {});
      },
    )
    : LayoutBuilder(
      builder: (context, constraints) {
        double availableWidth = constraints.maxWidth - 250;
        double cellSize = availableWidth / (widget.size.width * 2);
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
                      DefaultTextStyle(
                        style: TextStyle(
                          color: _index == 1 ? Colors.black : Colors.grey, 
                          fontSize: 40,
                          fontWeight: _index == 1 ? FontWeight.bold : FontWeight.normal,
                        ),
                        child: const Text("Player Field"),
                      ),
                      AbsorbPointer(
                        absorbing: _index != 1,
                        child: Container(
                          width: cellSize * widget.size.width,
                          height: cellSize * widget.size.height,
                          color: Colors.black26.withValues(alpha: 0.5),
                          child: FieldWidget(
                            size: widget.size,
                            cellSize: cellSize,
                            cells: _game.cells(1),
                            onTap: (x, y) {
                              final (result, index) = _game.shoot(x, y);
                              if (result == ShootResult.win) {
                                setState(() {
                                  _state = GameState.end;
                                  _win = true;
                                });
                              } else {
                                print('HomePage.build | index: $index');
                                setState(() {
                                  _index = index;
                                });
                              }
                              return result;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Enemy's battlefield
                  Column(
                    children: [
                      DefaultTextStyle(
                        style: TextStyle(
                          color: _index == 0 ? Colors.black : Colors.grey, 
                          fontSize: 40,
                          fontWeight: _index == 0 ? FontWeight.bold : FontWeight.normal,
                        ),
                        child: const Text("Enemy Field"),
                      ),
                      AbsorbPointer(
                        absorbing: _index != 0,
                        child: Container(
                          width: cellSize * widget.size.width,
                          height: cellSize * widget.size.height,
                          color: Colors.black26.withValues(alpha: 0.5),
                          child: FieldWidget(
                            size: widget.size,
                            cellSize: cellSize,
                            cells: _game.cells(0),
                            onTap: (x, y) {
                              final (result, index) = _game.shoot(x, y);
                              if (result == ShootResult.win) {
                                setState(() {
                                  _state = GameState.end;
                                  _win = false;
                                });
                              } else {
                                print('HomePage.build | index: $index');
                                setState(() {
                                  _index = index;
                                });
                              }
                              return result;
                            },
                          ),
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
///
///
enum GameState {
  game,
  end,
}