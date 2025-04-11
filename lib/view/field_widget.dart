import 'package:flutter/material.dart';
import 'package:nv/domain/models/cell.dart';
import 'package:nv/domain/models/shoot_result.dart';
import 'package:nv/view/cell_widget.dart';
///
/// Displays a game field grid with interactive cells.
/// Manages the layout and delegates cell rendering to [CellWidget].
class FieldWidget extends StatelessWidget {
  final Size size;
  final double cellSize;
  final List<List<Cell>> cells;
  final ShootResult Function(int, int) onTap;
  ///
  /// Creates a game field grid
  /// [size] - Size of the grid (number of cells per row/column)
  /// [cellSize] - Size of each individual cell in logical pixels
  /// [onTap] - Callback when a cell is tapped, provides cell index
  /// [cells] - Current state of all cells in the grid
  const FieldWidget({
    super.key,
    required this.size,
    required this.cellSize,
    required this.onTap,
    required this.cells,
  });
  //
  //
  @override
  Widget build(BuildContext context) {
    final count = size.width.toInt() * size.height.toInt();
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: size.width.toInt(),
        childAspectRatio: 1.0,
      ),
      itemCount: count,
      itemBuilder: (context, index) {
        final x = index.remainder(size.width).round();
        final y = index ~/ size.width;
        final cell = cells[x][y];
        // print('FieldWidget.build | x: $x, y: $y, cell: $cell, size: $cellSize');
        return CellWidget(
          size: cellSize,
          xy: (x, y),
          cell: cell,
          onTap: (x, y) => onTap(x, y),
        );
      },
    );
  }
}