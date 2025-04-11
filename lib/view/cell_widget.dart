import 'package:flutter/material.dart';
import 'package:nv/domain/models/cell.dart';
import 'package:nv/domain/models/shoot_result.dart';
///
/// Represents a single cell in the game grid with interactive behavior.
/// Handles visual representation based on cell state and user interactions.
class CellWidget extends StatefulWidget {
  final double size;
  final (int, int) xy;
  final Color color;
  final ShootResult Function(int, int) onTap;
  ///
  /// Creates a game grid cell
  /// [size] - Width and height of the cell in logical pixels
  /// [xy] - Position of the cell in the [Field]
  /// [cell] - Initial cell state
  /// [onTap] - Callback when cell is tapped
  CellWidget({
    super.key,
    required this.size,
    required this.xy,
    required Cell cell,
    required this.onTap,
  }):
    color = _colorSwitch(cell);
  ///
  /// Determines cell color based on current state
  static Color _colorSwitch(Cell cell) {
    switch (cell) {
      case Cell.empty: return Colors.transparent;
      case Cell.ship: return Colors.grey;
      case Cell.hit: return Colors.red;
      case Cell.miss: return Colors.white;
    }
  }
  //
  //
  @override
  State<CellWidget> createState() => _CellWidgetState();
}
//
//
class _CellWidgetState extends State<CellWidget> {
  Color _color = Colors.transparent;
  //
  //
  @override
  void initState() {
    _color = widget.color;
    super.initState();
  }
  //
  //
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final result = widget.onTap(widget.xy.$1, widget.xy.$2);
        if (result == ShootResult.hit) {
          _color = Colors.red;
        } else if (result == ShootResult.miss) {
          _color = Colors.white;
        }
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.2),
          color: _color,
        ),
      ),
    );
  }
}