class Fire {
  bool processShot(List<CellState> board, int index) {
    if (board[index] == CellState.ship) {
      board[index] = CellState.hit;
      return true;
    } else if (board[index] == CellState.empty) {
      board[index] = CellState.miss;
    }
    return false;
  }
}