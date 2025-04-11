import 'package:flutter/material.dart';
import 'package:nv/domain/models/game_status.dart';
///
/// Displays end game screen with result (win/lose) and restart button.
/// Shows different messages based on [gameResult] status.
class EndGamePage extends StatelessWidget {
  final GameStatus? gameResult;
  final VoidCallback onRestart;
  //
  // [gameResult] - determines which message to show
  // [onRestart] - callback when restart button is pressed
  const EndGamePage({
    super.key,
    required this.gameResult,
    required this.onRestart,
  });
  //
  // Builds the UI with game result message and restart button
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            gameResult == GameStatus.playerWin ? 'Поражение!' : 'Победа!',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: onRestart,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(
                  horizontal: 30, vertical: 15),
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