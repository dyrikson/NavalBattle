import 'package:nv/domain/models/cell.dart';
import 'package:nv/domain/models/shoot_result.dart';
///
/// Battle field, the area where ships located 
class Field {
  int _ships;
  final List<List<Cell>> _cells;
  ///
  ///
  List<List<Cell>> get cells => _cells;
  ///
  ///
  Field(List<List<Cell>> cells):
    _ships = 0,
    _cells = cells;
  ///
  /// User
  Field.user(int width, int height, int ships):
    _ships = ships,
    _cells = [
      [Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,],
      [Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,],
      [Cell.empty,Cell.ship,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,],
      [Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,],
      [Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,],
      [Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,],
      [Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,],
      [Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,],
      [Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,],
      [Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,Cell.empty,],
    ];
    // _cells = chunk(List.filled(width * height, Cell.empty), width);
  ///
  /// User of kind Computer
  Field.comp(int width, int height, int ships):
    _ships = ships,
    _cells = shipsInitialize(chunk(List.filled(width * height, Cell.empty), width));
  ///
  /// The shoot to this field with [x] and [y] of cell
  /// - Returns `Cell.hit` if ship was under the [x] and [y]
  /// - Returns `Cell.win` if last ship was shootted
  /// - Returns `Cell.miss` if `empty` or `hit` was under the [x] and [y]
  ShootResult shoot(x, y) {
    if (_cells[x][y] == Cell.ship) {
      _cells[x][y] = Cell.hit;
      _ships--;
      if (_ships <= 0) {
        return ShootResult.win;
      }
      return ShootResult.hit;
    } else if (_cells[x][y] == Cell.empty) {
      _cells[x][y] = Cell.miss;
      return ShootResult.miss;
    }
    return ShootResult.miss;
  }
}
///
/// 
List<List<T>> chunk<T>(List<T> array, [int size = 1]) {
  if (size < 1) {
    throw ArgumentError('Size must be greater than 0');
  }
  List<List<T>> chunks = [];
  for (int i = 0; i < array.length; i += size) {
    int end = i + size;
    if (end > array.length) {
      end = array.length;
    }
    chunks.add(array.sublist(i, end));
  }
  return chunks;
}
///
///
List<List<Cell>> shipsInitialize(List<List<Cell>> cells) {
  final List<List<int>> indexShips = [
    [1,3,5,7], // row 0
    [1,2,3,5,6,7], // row 2
    [1,2,4,5,7,8], // row 4
    [1,2,3,4] // row 6
  ];
  List<int> rows = [0,2,4,6];
  var count = 0;
  for (var ships in indexShips) {
    for (var index in ships) {
      cells[rows[count]][index] = Cell.ship;
    }
    count ++;
    if (count == 3)
      break;
  }
  return cells;
}