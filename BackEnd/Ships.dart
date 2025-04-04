class Ships {
  final List<CellState> ships = List.filled(100, CellState.empty);
  final List<CellState> shipsEnemy = List.filled(100, CellState.empty);
  final List<int> indexShips = [1,3,5,7, 21,22,23, 25,26,27, 41,42, 44,45, 47,48, 81,82,83,84];
  final List<int> indexShipsEnemy = [1,3,5,7, 21,22,23, 25,26,27, 41,42, 44,45, 47,48, 81,82,83,84];
  int shipsCount = 0;
  Ships() {
    for(var index in indexShipsEnemy) {
      shipsEnemy[index] = CellState.ship;
    }
    for(var index in indexShips) {
      ships[index] = CellState.ship;
    }
  }
}