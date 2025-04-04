import 'package:flutter/material.dart';
import 'package:nv/domain/cell_state.dart';
///
/// ...
class GridCell extends StatelessWidget {
  final int index;
  final double size;
  final bool playerRecognition;
  final VoidCallback onTap;
  final List<CellState> board;
  ///
  /// ...
  const GridCell({
    super.key,
    required this.index,
    required this.size,
    required this.playerRecognition,
    required this.onTap,
    required this.board,
  });
  ///
  ///
  Color _colorSwitch(List<CellState> board){
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
          color: _colorSwitch(board),
        ),
      ),
    );
  }
}