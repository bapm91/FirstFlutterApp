class MoveModel {

  String _moveNumber;
  String _moveOffer;
  String _moveHint;

  MoveModel(this._moveNumber, this._moveOffer, [this._moveHint]);

  String get getMoveHint => _moveHint;

  String get moveOffer => _moveOffer;

  String get moveNumber => _moveNumber;

  void setMoveHint(String value) {
    _moveHint = value;
  }
}
