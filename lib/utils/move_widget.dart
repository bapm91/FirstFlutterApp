import 'package:first_flutter_app/models/move_model.dart';
import 'package:flutter/material.dart';

class MoveWidget extends StatelessWidget {
  final MoveModel moveModel;

  final textSize = 20.0;

  const MoveWidget({this.moveModel}):assert(moveModel != null);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.grey[100]
        ),
      child: Padding(
        padding: EdgeInsets.only(left: 18, top: 0, right: 18, bottom: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            '${moveModel.moveNumber}.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: textSize,
              fontStyle: FontStyle.normal,
            ),
          ),
          Container(
            width: 25,
          ),
          Container(
            color: Colors.black54,
            width: 1,
            height: 25,
          ),
          Container(
            width: 25,
          ),
          Text(
            '${moveModel.moveOffer}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: textSize,
              fontStyle: FontStyle.italic,
            ),
          ),
          Container(
            width: 25,
          ),
          Container(
            color: Colors.black54,
            width: 1,
            height: 25,
          ),
          Container(
            width: 25,
          ),
          Text(
            '${moveModel.getMoveHint}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: textSize,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    ));
  }
}
