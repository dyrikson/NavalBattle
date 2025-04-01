import 'package:flutter/material.dart';
import 'package:nv/logic.dart';

class Field extends StatelessWidget {
  final int gridSize;
  final double cellSize;
  final List<bool> ships;
  final List<bool>? hits;
  final bool playerRecognition;
  final void Function(int) onCellTap;
  const Field({
    super.key,
    required this.gridSize,
    required this.cellSize,
    required this.ships,
    this.hits,
    required this.playerRecognition,
    required this.onCellTap,
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
        bool isShip = ships[index];
        bool isHit = hits != null && hits![index];
        return GridCell(
          index: index,
          size: cellSize,
          isShip: isShip,
          isHit: isHit,
          playerRecognition: playerRecognition,
          onTap: () => onCellTap(index),
        );
      },
    );
  }
}
class GridCell extends StatelessWidget {
  final int index;
  final double size;
  final bool isShip;
  final bool isHit;
  final bool playerRecognition;
  final VoidCallback onTap;
  GridCell({
    super.key,
    required this.index,
    required this.size,
    required this.isShip,
    required this.isHit,
    required this.playerRecognition,
    required this.onTap,
  });
  var field = FieldLogic();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.2),
          color: field.getCellColor(isHit, isShip, playerRecognition),
        ),
      ),
    );
  }
}