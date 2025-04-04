import 'package:flutter/material.dart';
import 'package:nv/view/home_page.dart';
///
/// ...
class AppWidget extends StatelessWidget {
  const AppWidget({super.key});
  //
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/BattleShip.jpg"), fit: BoxFit.cover)),
          child: const HomePage(),
        )
    );
  }
}