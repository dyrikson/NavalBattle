///
/// An enumeration describing the state of each field's cell
/// The cell can be a ship, an  emptiness, a hit (when the player hits a ship)
/// or a miss (when the player hits an empty cell)
enum Cell {
  empty,
  ship,
  hit,
  miss,
}