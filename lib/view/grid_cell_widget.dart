import 'package:flutter/material.dart';
import 'package:nv/domain/models/cell_state.dart';
///
/// Represents a single cell in the game grid with interactive behavior.
/// Handles visual representation based on cell state and user interactions.
class GridCell extends StatelessWidget {
  final int index;
  final double size;
  final bool playerRecognition;
  final VoidCallback onTap;
  final List<CellState> board;
  //
  // Creates a game grid cell
  // [index] - Position of the cell in the grid
  // [size] - Width and height of the cell in logical pixels
  // [playerRecognition] - True if cell belongs to player, false if enemy
  // [onTap] - Callback when cell is tapped
  // [board] - Reference to the game board state
  const GridCell({
    super.key,
    required this.index,
    required this.size,
    required this.playerRecognition,
    required this.onTap,
    required this.board,
  });
  // Determines cell color based on current state
  Color colorSwitch(List<CellState> board) {
    switch (board[index]) {
      case CellState.empty: return Colors.transparent;
      case CellState.ship: return Colors.grey;
      case CellState.hit: return Colors.red;
      case CellState.miss: return Colors.white;
    }
  }
  // Builds the visual representation of the cell
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.2),
          color: colorSwitch(board),
        ),
      ),
    );
  }
}