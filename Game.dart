import 'package:flutter/material.dart';

class Game {
  final int gridSize = 10;
  final List<bool> hits = List.generate(100, (_) => false);
  final List<bool> hitsEnemy = List.generate(100, (_) => false);
  bool turn = false;
  bool gameEndFlag = false;
  bool whichWin = false;
  void turnChange(bool isShip, bool plaerRecognition){
    if (!isShip && !plaerRecognition) {
      turn = false;
    }
    else {
      if(!isShip && plaerRecognition){
        turn = true;
      }
    }
  }
  void turnCheck(int index, Ships ship, bool playerRecognition) {
    if (!playerRecognition) {
      hitsEnemy[index] = true;
      bool isShip = ship.ships[index];
      if (gameEnd(ship.ships, hitsEnemy, whichWin, false)) {
        gameEndFlag = true;
      }
      turnChange(isShip, playerRecognition);
    }
    else {
      hits[index] = true;
      bool isShip = ship.shipsEnemy[index];
      if(gameEnd(ship.shipsEnemy, hits, whichWin, true)) {
        gameEndFlag = true;
      }
      turnChange(isShip, playerRecognition);
    }
  }
  bool gameEnd(List<bool> hits, List<bool> ships, bool whichWin, bool playerRecognition){
    int countOfHits = 0;
    for(int index = 0; index < 100; index++) {
      if(ships[index] && hits[index]){
        countOfHits++;
      }
    }
    if (countOfHits == 20 && playerRecognition) {
      this.whichWin = true;
      return true;
    }
    else {
      if(countOfHits == 20 && !playerRecognition) {
        this.whichWin = false;
        return true;
      }
    }
    countOfHits = 0;
    return false;
  }
}