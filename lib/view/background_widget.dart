import 'package:flutter/material.dart';
///
/// Just a background loaded from image file
class GameBackGround extends StatelessWidget {
  final Widget child;
  final String imagePath;
  const GameBackGround({
    super.key,
    required this.child,
    this.imagePath = "assets/BattleShip.jpg",
  });
  // Container containing an image
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}