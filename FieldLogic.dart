class FieldLogic {
  Color getCellColor(bool isHit, bool isShip, bool playerRecognition) {
    if (isHit && isShip) {
      return Colors.red;
    } else if (isHit) {
      return Colors.black;
    } else if (isShip && !playerRecognition) {
      return Colors.red.withOpacity(0.5);
    } else if (isShip) {
      return Colors.blue;
    } else {
      return Colors.transparent;
    }
  }
}