import 'package:flutter/material.dart';
import 'package:nv/logic.dart';

class ShipPlacementBackGround extends StatelessWidget {
  const ShipPlacementBackGround({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/BattleShip.jpg"), fit: BoxFit.cover)),
          child: const ShipPlacementScreen(),
        )
    );
  }
}
class ShipPlacementScreen extends StatefulWidget {
  const ShipPlacementScreen({super.key});
  @override
  _ShipPlacementScreen createState() => _ShipPlacementScreen();
}
class _ShipPlacementScreen extends State<ShipPlacementScreen> {
  var ship = Ships();
  void _GameScreenNavigation() {
    if(ship.shipPlacementCheck()) {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameBackGround(ship: ship),
          ),
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Морской бой',
          style: TextStyle(
            color: Colors.black,
            fontSize: 50,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: Text('Расставьте корабли',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black)),
          ),
          Center(
            child: Container(
              width: 50 * 10,
              height: 50 * 10,
              color: Colors.black26.withOpacity(0.5),
              child: Field(
                gridSize: 10,
                cellSize: 50,
                ships: ship.ships,
                playerRecognition: true,
                onCellTap: (index) {
                  setState(() {
                    ship.countOfShipsCheck(index);
                  });
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  _GameScreenNavigation();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Начать игру'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}