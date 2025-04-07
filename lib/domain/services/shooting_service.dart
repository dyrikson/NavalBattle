import 'package:nv/domain/models/cell_state.dart';
///
/// Abstract service for shooting/hitting logic in battleship game
/// Defines the contract for shooting implementations
/// Returns true if shot hit a ship, false otherwise
abstract class ShootingService {
  bool shoot(List<CellState> board, int index);
}
///
/// Concrete implementation of shooting service
/// Handles actual shooting logic and board state modification
class Fire implements ShootingService {
  // Rules:
  // - Hits turn ship cells to [CellState.hit]
  // - Misses turn empty cells to [CellState.miss]
  @override
  bool shoot(List<CellState> board, int index) {
    if (board[index] == CellState.ship) {
      board[index] = CellState.hit;
      return true;
    } else if (board[index] == CellState.empty) {
      board[index] = CellState.miss;
      return false;
    }
    return false;
  }
}