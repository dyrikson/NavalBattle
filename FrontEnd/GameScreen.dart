import 'package:flutter/material.dart';
import 'package:nv/logic.dart';


class GameBackGround extends StatelessWidget {
  final Ships ship;
  const GameBackGround({super.key, required this.ship});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/BattleShip.jpg"), fit: BoxFit.cover)),
          child: GameScreen(ship: ship),
        ));
  }
}
class GameScreen extends StatefulWidget {
  final Ships ship;
  const GameScreen({super.key, required this.ship});
  @override
  _GameScreen createState() => _GameScreen();
}
class _GameScreen extends State<GameScreen> {
  var game = Game();
  void gameEndNavigation(){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) {
              return EndGameBackGround(whichWin: game.whichWin,);
            }
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double availableWidth = constraints.maxWidth - 250;
        double cellSize = availableWidth / (game.gridSize * 2);
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
                        width: cellSize * game.gridSize,
                        height: cellSize * game.gridSize,
                        color: Colors.black26.withOpacity(0.5),
                        child: Field(
                          gridSize: 10,
                          cellSize: cellSize,
                          ships: widget.ship.ships,
                          hits: game.hitsEnemy,
                          playerRecognition: true,
                          onCellTap: (index) {
                            if (game.turn) {
                              setState(() {
                                game.turnCheck(index, widget.ship, false);
                                if (game.gameEndFlag) {
                                  gameEndNavigation();
                                }
                              });
                            }
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
                        width: cellSize * game.gridSize,
                        height: cellSize * game.gridSize,
                        color: Colors.black26.withOpacity(0.5),
                        child: Field(
                          gridSize: 10,
                          cellSize: cellSize,
                          ships: widget.ship.shipsEnemy,
                          hits: game.hits,
                          playerRecognition: false,
                          onCellTap: (index) {
                            if (!game.turn) {
                              setState(() {
                                game.turnCheck(index, widget.ship, true);
                                if (game.gameEndFlag) {
                                  gameEndNavigation();
                                }
                              });
                            }
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