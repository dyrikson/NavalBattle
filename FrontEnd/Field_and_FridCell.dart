import 'package:flutter/material.dart';
import 'package:nv/logic.dart';

class Field extends StatelessWidget {
  final int gridSize;
  final double cellSize;
  final bool playerRecognition;
  final List<CellState> board;
  final void Function(int) onCellTap;
  const Field({
    super.key,
    required this.gridSize,
    required this.cellSize,
    required this.playerRecognition,
    required this.onCellTap,
    required this.board,
  });
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
class GridCell extends StatelessWidget {
  final int index;
  final double size;
  final bool playerRecognition;
  final VoidCallback onTap;
  final List<CellState> board;
  const GridCell({
    super.key,
    required this.index,
    required this.size,
    required this.playerRecognition,
    required this.onTap,
    required this.board,
  });
  Color colorSwitch(List<CellState> board){
    switch (board[index]) {
      case CellState.empty: return Colors.transparent;
      case CellState.ship: return Colors.grey;
      case CellState.hit: return Colors.red;
      case CellState.miss: return Colors.white;
    }
  }
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