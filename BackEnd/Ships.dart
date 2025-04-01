class Ships {
  final List<bool> ships = List.generate(100, (_) => false);
  final List<bool> shipsEnemy = List.generate(100, (_) => false);
  final List<int> indexShipsEnemy = [1,3,5,7, 21,22,23, 25,26,27, 41,42, 44,45, 47,48, 81,82,83,84];
  int shipsCount = 0;
  Ships() {
    for(var index in indexShipsEnemy) {
      shipsEnemy[index] = true;
    }
  }
  bool shipPlacementCheck() {
    if(shipsCount == 20) {
      return true;
    }
    return false;
  }
  void countOfShipsCheck (int index) {
    if (shipsCount < 20) {
      if(!ships[index]) {
        ships[index] = !ships[index];
        shipsCount++;
      }
      else {
        ships[index] = !ships[index];
        shipsCount--;
      }
    }
  }
}