import 'dart:async';
import 'package:nv/BackEnd/Fire.dart';
import 'package:nv/BackEnd/Ships.dart'

enum CellState { empty, ship, hit, miss }
enum GameResult { ongoing, playerWin, playerLose }

class Game {
  late final Fire fire;
  late final Ships ships;
  Completer<(int, bool)> _shotCompleter = Completer();
  final StreamController<void> _updateController = StreamController.broadcast();
  final StreamController<GameResult> _gameOverController = StreamController.broadcast();
  bool _isPlayerTurn = false;
  bool _lastShotHit = false;
  Game(Fire f, Ships s) {
    this.fire = f;
    this.ships = s;
    _startGameLoop();
  }
  Future<void> _startGameLoop() async {
    while (!_isGameOver(ships)) {
      final (index, playerRecognition) = await _waitForPlayerShot();
      if(playerRecognition && _isPlayerTurn) {
        _lastShotHit = fire.processShot(ships.shipsEnemy, index);
        _updateController.add(null);
        if (!_lastShotHit) {
          _isPlayerTurn = false;
        }
      }
      else if(!playerRecognition && !_isPlayerTurn) {
        _lastShotHit = fire.processShot(ships.ships, index);
        _updateController.add(null);
        if (!_lastShotHit) {
          _isPlayerTurn = true;
        }
      }
    }
  }
  bool _isGameOver(Ships ships) {
    final playerWins = !ships.shipsEnemy.any((e) => e == CellState.ship);
    final enemyWins = !ships.ships.any((e) => e == CellState.ship);

    if (playerWins) {
      _gameOverController.add(GameResult.playerWin);
      return true;
    } else if (enemyWins) {
      _gameOverController.add(GameResult.playerLose);
      return true;
    }
    return false;
  }
  Future<(int, bool)> _waitForPlayerShot() async {
    _shotCompleter = Completer();
    return _shotCompleter.future;
  }
  void sendPlayerShot(int index, bool playerRecognition) {
    if (!_shotCompleter.isCompleted) {
      _shotCompleter.complete((index, playerRecognition));
    }
  }
  Stream<void> get onUpdate => _updateController.stream;
  Stream<GameResult> get onGameOver => _gameOverController.stream;
}
