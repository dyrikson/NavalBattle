import 'package:flutter/material.dart';
import 'package:nv/logic.dart';

class EndGameBackGround extends StatelessWidget {
  final bool whichWin;
  const EndGameBackGround({super.key, required this.whichWin});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/BattleShip.jpg"), fit: BoxFit.cover)),
          child: EndGameScreen(whichWin: whichWin,),
        )
    );
  }
}
class EndGameScreen extends StatelessWidget {
  final bool whichWin;
  const EndGameScreen({super.key, required this.whichWin});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          child: Center(
            child: Text(
              whichWin ? 'Вы выиграли!': 'Вы проиграли.   :(',
              style: const TextStyle(color: Colors.black,
                  fontSize: 100),
            ),
          ),
        )
    );
  }
}