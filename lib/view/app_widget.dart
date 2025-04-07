import 'package:flutter/material.dart';
import 'package:nv/view/home_page.dart';
import 'package:nv/view/background_widget.dart';
///
/// Main widget that starts the app
class AppWidget extends StatelessWidget {
  const AppWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: GameBackGround(
          child: HomePage(),
        )
    );
  }
}