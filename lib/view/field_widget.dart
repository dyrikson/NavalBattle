import 'package:flutter/material.dart';
import 'package:nv/domain/models/cell_state.dart';
import 'package:nv/view/grid_cell_widget.dart';
///
/// Displays a game field grid with interactive cells.
/// Manages the layout and delegates cell rendering to [GridCell].
class Field extends StatelessWidget {
  final int gridSize;
  final double cellSize;
  final bool playerRecognition;
  final List<CellState> board;
  final void Function(int) onCellTap;
  //
  // Creates a game field grid
  // [gridSize] - Size of the grid (number of cells per row/column)
  // [cellSize] - Size of each individual cell in logical pixels
  // [playerRecognition] - Whether this field belongs to the player (true) or enemy (false)
  // [board] - Current state of all cells in the grid
  // [onCellTap] - Callback when a cell is tapped, provides cell index
  const Field({
    super.key,
    required this.gridSize,
    required this.cellSize,
    required this.playerRecognition,
    required this.onCellTap,
    required this.board,
  });
  // Builds a square grid of [GridCell] widgets
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridSize,
        childAspectRatio: 1.0,
      ),
      itemCount: gridSize * gridSize,
      itemBuilder: (context, index) {
        return GridCell(
          index: index,
          size: cellSize,
          playerRecognition: playerRecognition,
          board: board,
          onTap: () => onCellTap(index),
        );
      },
    );
  }
}