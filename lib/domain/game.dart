import 'package:nv/domain/models/cell_state.dart';
import 'package:nv/domain/models/game_status.dart';
import 'package:nv/domain/services/shooting_service.dart';
import 'package:nv/domain/models/ships.dart';
///
/// Manages game flow, turns, and win/lose conditions for battleship game.
/// Handles player/enemy turns and tracks game state.
class Game {
  late final Fire fire;
  late final Ships ships;
  late int _lastPlayerMove;
  late bool _player;
  GameStatus status = GameStatus.ongoing;
  bool _isPlayerTurn = false;
  bool _lastShotHit = false;
  //
  // Initializes game with shooting service and ship configurations
  Game(Fire f, Ships s) {
    this.fire = f;
    this.ships = s;
  }
  //
  // Processes a game turn for player or enemy
  // [position] - cell index being shot at
  // [playerRecognition] - identifies if move is made by player
  void gameTurn(int position, bool playerRecognition) {
    _lastPlayerMove = position;
    _player = playerRecognition;
    if (!_isGameOver(ships)) {
      if(_player && _isPlayerTurn) {
        _lastShotHit = fire.shoot(ships.shipsEnemy, _lastPlayerMove);
        if (!_lastShotHit) {
          _isPlayerTurn = false;
        }
      }
      else if(!_player && !_isPlayerTurn) {
        _lastShotHit = fire.shoot(ships.ships, _lastPlayerMove);
        if (!_lastShotHit) {
          _isPlayerTurn = true;
        }
      }
    }
  }
  //
  // Checks if game should end (all ships sunk)
  bool _isGameOver(Ships ships) {
    final playerWins = !ships.shipsEnemy.any((e) => e == CellState.ship);
    final enemyWins = !ships.ships.any((e) => e == CellState.ship);
    if (playerWins && _player) {
      status = GameStatus.playerWin;
      return true;
    }
    else if(enemyWins && !_player) {
      status = GameStatus.playerLose;
      return true;
    }
    return false;
  }
}