import 'package:flutter/material.dart';
///
/// Displays end game screen with result (win/lose) and restart button.
/// Shows different messages based on [win] status.
class EndGamePage extends StatelessWidget {
  final bool win;
  final Function() onDone;
  ///
  /// [gameResult] - determines which message to show
  /// [onRestart] - callback when restart button is pressed
  const EndGamePage({
    super.key,
    required this.win,
    required this.onDone,
  });
  //
  //
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            win ? 'Победа!' : 'Поражение!',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => onDone(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 15,
              ),
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
}