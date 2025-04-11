import 'package:nv/domain/models/cell.dart';
import 'package:nv/domain/models/field.dart';
import 'package:nv/domain/models/shoot_result.dart';
///
/// Manages game flow, turns, and win/lose conditions for battleship game.
/// Handles player/enemy turns and tracks game state.
class Game {
  final List<Field> _fields;
  int _index = 0;
  ///
  /// Initializes game with [Field]'s of mambers,
  /// which contains areas of ships
  Game(List<Field> fields):
    _fields = fields;
  ///
  /// Makes a game step, shooting to the following [Field]
  ///
  /// The shoot to this field with [x] and [y] of cell
  /// - Returns `Cell.hit` if ship was under the [x] and [y]
  /// - Returns `Cell.win` if last ship was shootted
  /// - Returns `Cell.miss` if `empty` or `hit` was under the [x] and [y]
  (ShootResult, int) shoot(x, y) {
    final result = _fields[_index].shoot(x, y);
    if (result != ShootResult.hit) {
      _index++;
      if (_index > _fields.length) {
        _index = 0;
      }
    }
    return (result, _index);
  }
  ///
  ///
  List<List<Cell>> cells(index) {
    return _fields[index].cells;
  }
}