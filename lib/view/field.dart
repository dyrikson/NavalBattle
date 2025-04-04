import 'package:flutter/material.dart';
import 'package:nv/domain/cell_state.dart';
import 'package:nv/view/grid_cell.dart';

///
/// ...
class Field extends StatelessWidget {
  final int gridSize;
  final double cellSize;
  final bool playerRecognition;
  final List<CellState> board;
  final void Function(int) onCellTap;
  ///
  /// ...
  const Field({
    super.key,
    required this.gridSize,
    required this.cellSize,
    required this.playerRecognition,
    required this.onCellTap,
    required this.board,
  });
  //
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
