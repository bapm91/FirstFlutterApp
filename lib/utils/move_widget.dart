import 'package:first_flutter_app/models/move_model.dart';
import 'package:flutter/material.dart';

class MoveWidget extends StatelessWidget {
  final MoveModel moveModel;

  const MoveWidget({this.moveModel}):assert(moveModel != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            '${moveModel.moveNumber}.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 30,
              fontStyle: FontStyle.normal,
            ),
          ),
          Container(
            width: 25,
          ),
          Container(
            color: Colors.black54,
            width: 1,
            height: 40,
          ),
          Container(
            width: 25,
          ),
          Text(
            '${moveModel.moveOffer}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 30,
              fontStyle: FontStyle.italic,
            ),
          ),
          Container(
            width: 25,
          ),
          Container(
            color: Colors.black54,
            width: 1,
            height: 40,
          ),
          Container(
            width: 25,
          ),
          Text(
            '${moveModel.getMoveHint}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 30,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    ));
  }
}
