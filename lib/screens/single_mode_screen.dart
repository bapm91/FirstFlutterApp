import 'package:first_flutter_app/models/move_model.dart';
import 'package:first_flutter_app/utils/drag_box.dart';
import 'package:first_flutter_app/utils/move_widget.dart';
import 'package:flutter/services.dart';
import 'package:responsive_container/responsive_container.dart';
import 'package:flutter/material.dart';
import 'dart:math';

// SinglePayer have some mode [easy_mode, normal_mode, hard_mode, pro_mode]
// [pro_mode] - mode with timer (100 sec) and with out list of moves before
// [master] - mode with out timer and with out list of moves before
// [hard_mode] - with timer (100 sec)
// [normal mode] - timer (200 sec)
// [easy mode] - no timer

enum DifficultyLevel { EASY, NORMAL, HARD, MASTER, PRO}

class SingleModeGameScreen extends StatefulWidget {
  @override
  State createState() {
    return SingleModeGameScreenState();
  }
}

class SingleModeGameScreenState extends State<SingleModeGameScreen> {
  List<MoveModel> movesList;
  ScrollController _scrollController = new ScrollController();

  final textSize = 20.0;

  List<DragBox> evenNumbersDragList;
  List<DragBox> oddNumbersDragList;

  List<String> valueNewMove;

  DifficultyLevel level;

  List<String> number;

  @override
  void initState() {
    super.initState();
    refreshAll();
  }

  void initKeys() {
    evenNumbersDragList = [
      DragBox('1'),
      DragBox('3'),
      DragBox('5'),
      DragBox('7'),
      DragBox('9')
    ];
    oddNumbersDragList = [
      DragBox('2'),
      DragBox('4'),
      DragBox('6'),
      DragBox('8'),
      DragBox('0'),
    ];
    valueNewMove = [' ', ' ', ' ', ' '];
  }

  void refreshKeys() {
    setState(() {
      evenNumbersDragList.forEach((dragBox) {
        dragBox.dragBoxState.setVisibility(true);
      });
      oddNumbersDragList.forEach((dragBox) {
        dragBox.dragBoxState.setVisibility(true);
      });
      valueNewMove = [' ', ' ', ' ', ' '];
    });
  }

  void refreshAll() {
    setState(() {
      initKeys();
      movesList = List<MoveModel>();
      number = getRandomNumber();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
        backgroundColor: Colors.blue[100],
        body: Column(children: <Widget>[
          ResponsiveContainer(
            heightPercent: 5.0,
            widthPercent: 100.0,
          ),
          ResponsiveContainer(
            heightPercent: 1.0,
            widthPercent: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('№'),
                Container(
                  width: 10,
                ),
                Text('Moves'),
                Container(
                  width: 10,
                ),
                Text('Hint')
              ],
            ),
          ),
          ResponsiveContainer(
            heightPercent: 1.0,
            widthPercent: 100.0,
          ),
          ResponsiveContainer(
              heightPercent: 70.0,
              widthPercent: 100.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue[700]),
                      borderRadius: BorderRadius.all(Radius.circular(11)),
                      color: Colors.lightBlueAccent),
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: movesList.length,
                    itemBuilder: (context, position) {
                      return Padding(
                        padding: EdgeInsets.all(5),
                        child: MoveWidget(moveModel: movesList[position]),
                      );
                    },
                  ),
                ),
              )),
          ResponsiveContainer(
            heightPercent: 0.1,
            widthPercent: 100.0,
            child: Container(
              color: Colors.black54,
              height: 1,
            ),
          ),
          ResponsiveContainer(
            heightPercent: 7.0, //value percent of screen total height
            widthPercent: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  iconSize: 24,
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    refreshKeys();
                  },
                  tooltip: 'Clear',
                ),
                dragTargetWidget(0),
                dragTargetWidget(1),
                dragTargetWidget(2),
                dragTargetWidget(3),
                IconButton(
                  icon: Icon(Icons.subdirectory_arrow_left),
                  onPressed: () {
                    checkMove();
                  },
                  tooltip: 'Check',
                )
              ],
            ),
          ),
          ResponsiveContainer(
            heightPercent: 0.1,
            widthPercent: 100.0,
            child: Container(
              color: Colors.black54,
              height: 1,
            ),
          ),
          ResponsiveContainer(
            heightPercent: 2,
            widthPercent: 100.0,
          ),
          ResponsiveContainer(
            heightPercent: 6.0,
            widthPercent: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                evenNumbersDragList[0],
                evenNumbersDragList[1],
                evenNumbersDragList[2],
                evenNumbersDragList[3],
                evenNumbersDragList[4],
                Container(
                  width: 10,
                ),
              ],
            ),
          ),
          ResponsiveContainer(
            heightPercent: 6.0, //value percent of screen total height
            widthPercent: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 10,
                ),
                oddNumbersDragList[0],
                oddNumbersDragList[1],
                oddNumbersDragList[2],
                oddNumbersDragList[3],
                oddNumbersDragList[4]
              ],
            ),
          )
        ]));
  }

  checkMove() {
    if (valueNewMove.contains(' ')) {
      _showSnackBar(context, 'Some cell are empty!');
      return;
    }

    MoveModel newMove = MoveModel((movesList.length + 1).toString(),
        '${valueNewMove[0] + valueNewMove[1] + valueNewMove[2] + valueNewMove[3]}');

    int repeatCount = 0;
    int rightPlaceCount = 0;

    valueNewMove.forEach((element) {
      if (number.contains(element)) {
        repeatCount++;
        if (number[valueNewMove.indexOf(element)] == element) {
          rightPlaceCount++;
        }
      }
    });

    newMove.setMoveHint('$repeatCount:$rightPlaceCount');

    setState(() {
      movesList.add(newMove);
      refreshKeys();
      if (rightPlaceCount == 4) {
        showWinAlert(context);
      }
    });

    scroll();
  }

  void _showSnackBar(BuildContext context, String message) {
    // TODO call this method rightly
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  scroll() async {
    Future.delayed(const Duration(milliseconds: 40), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    });
  }

  static List<String> getRandomNumber() {
    List<String> result = List();
    result.add(Random().nextInt(10).toString());
    for (int i = 0; i < 3; i++) {
      String num;
      do {
        num = Random().nextInt(10).toString();
      } while (result.contains(num));
      result.add(num);
    }

    return result;
  }

  void showStartAlert(BuildContext context) {
    //TODO call this method rightly
    setState(() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Singleplayer"),
            content: new Text("Choose your dificalty level?"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Easy"),
                onPressed: () {
                  level = DifficultyLevel.EASY;
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("Normal"),
                onPressed: () {
                  level = DifficultyLevel.NORMAL;
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("Hard"),
                onPressed: () {
                  level = DifficultyLevel.HARD;
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("Master"),
                onPressed: () {
                  level = DifficultyLevel.MASTER;
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("Pro"),
                onPressed: () {
                  level = DifficultyLevel.PRO;
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }

  void showWinAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("You Win!", style: TextStyle(fontSize: 20)),
          content: new Text("Play againe?", style: TextStyle(fontSize: 20)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes", style: TextStyle(fontSize: 20)),
              onPressed: () {
                refreshAll();
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("No", style: TextStyle(fontSize: 20)),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget dragTargetWidget(int index) {
    return DragTarget(
      onAccept: (String data) {
        if (valueNewMove[index] != ' ') {
          for (int i = 0; i < evenNumbersDragList.length; i++) {
            if (valueNewMove[index] == evenNumbersDragList[i].label) {
              evenNumbersDragList[i].dragBoxState.setVisibility(true);
              valueNewMove[index] = data;
            }
          }
        }

        if (valueNewMove[index] != data) {
          for (int i = 0; i < oddNumbersDragList.length; i++) {
            if (valueNewMove[index] == oddNumbersDragList[i].label) {
              oddNumbersDragList[i].dragBoxState.setVisibility(true);
            }
          }
        }

        valueNewMove[index] = data;
      },
      builder: (
        context,
        accepted,
        rejected,
      ) {
        return Container(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: valueNewMove[index] != ' '
                ? Container(
                    width: 40.0,
                    height: 60.0,
                    decoration: oddNumbersDragList[index]
                        .dragBoxState
                        .getSimpleDecoration(),
                    child: Center(
                      child: Text(
                        accepted.isEmpty ? valueNewMove[index] : " ",
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  )
                : Container(
                    color: Colors.transparent,
                    child: Center(
                      child:
                          oddNumbersDragList[index].dragBoxState.getDotPoint(),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
