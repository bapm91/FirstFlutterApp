import 'package:first_flutter_app/models/move_model.dart';
import 'package:first_flutter_app/utils/move_widget.dart';
import 'package:flutter/services.dart';
import 'package:responsive_container/responsive_container.dart';
import 'package:flutter/material.dart';
import 'dart:math';

// SinglePayer have some mode [easy_mode, normal_mode, hard_mode, pro_mode]
// [pro_mode] - mode with out list of moves before
// [hard_mode] - with timer (100 sec)
// [normal mode] - timer (200 sec)
// [easy mode] - no timer

enum DifficultyLevel { EASY, NORMAL, HARD, PRO }

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

  List<String> number = getRandomNumber();

  List<bool> textActive = [false, false, false, false];
  List<String> valueNewMove = [' ', ' ', ' ', ' '];

  @override
  void initState() {
    super.initState();

    if (movesList == null) {
      movesList = List<MoveModel>();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
        backgroundColor: Colors.blue[100],
        body: Column(
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ResponsiveContainer(
                heightPercent: 5.0, //value percent of screen total height
                widthPercent: 100.0,
              ),
              ResponsiveContainer(
                heightPercent: 1.0, //value percent of screen total height
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
                heightPercent: 1.0, //value percent of screen total height
                widthPercent: 100.0,
              ),
              ResponsiveContainer(
                  heightPercent: 70.0, //value percent of screen total height
                  widthPercent: 100.0,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: getClickedBorderColor(0)),
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                            color: Colors.lightBlueAccent
                        ),
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
                      ),)
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
                heightPercent: 7.0, //value percent of screen total height
                widthPercent: 100.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      iconSize: 24,
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        clearAllTextFields();
                      },
                      tooltip: 'Clear',
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: InkWell(
                          child: Container(
                            width: 40,
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: getClickedBorderColor(0)),
                                borderRadius:
                                BorderRadius.all(Radius.circular(11)),
                                color: getBackgroundColor(0)),
                            child: Center(
                              child: Text(
                                valueNewMove[0],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: getClickedTextColor(0),
                                  fontSize: textSize,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              textActive[0] = !textActive[0];
                              textActive[1] = false;
                              textActive[2] = false;
                              textActive[3] = false;
                            });
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: InkWell(
                          child: Container(
                            width: 40,
                            height: 35,
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: getClickedBorderColor(1)),
                                borderRadius:
                                BorderRadius.all(Radius.circular(11)),
                                color: getBackgroundColor(1)),
                            child: Center(
                              child: Text(
                                valueNewMove[1],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: getClickedTextColor(1),
                                  fontSize: textSize,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              textActive[1] = !textActive[1];
                              textActive[0] = false;
                              textActive[2] = false;
                              textActive[3] = false;
                            });
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: InkWell(
                          child: Container(
                            width: 40,
                            height: 35,
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: getClickedBorderColor(2)),
                                borderRadius:
                                BorderRadius.all(Radius.circular(11)),
                                color: getBackgroundColor(2)),
                            child: Center(
                              child: Text(
                                valueNewMove[2],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: getClickedTextColor(2),
                                  fontSize: textSize,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              textActive[2] = !textActive[2];
                              textActive[0] = false;
                              textActive[1] = false;
                              textActive[3] = false;
                            });
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: InkWell(
                          child: Container(
                            width: 40,
                            height: 35,
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: getClickedBorderColor(3)),
                                borderRadius:
                                BorderRadius.all(Radius.circular(11)),
                                color: getBackgroundColor(3)),
                            child: Center(
                              child: Text(
                                valueNewMove[3],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: getClickedTextColor(3),
                                  fontSize: textSize,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              textActive[3] = !textActive[3];
                              textActive[0] = false;
                              textActive[1] = false;
                              textActive[2] = false;
                            });
                          }),
                    ),
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
                    InkWell(
                        child: Container(
                          width: 40,
                          height: 35,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius:
                              BorderRadius.all(Radius.circular(11)),
                              color: Color(0x22000000)),
                          child: Center(
                            child: Text(
                              '1',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: textSize,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          setValueInNewMove(1);
                        }),
                    InkWell(
                        child: Container(
                          width: 40,
                          height: 35,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius:
                              BorderRadius.all(Radius.circular(11)),
                              color: Color(0x22000000)),
                          child: Center(
                            child: Text(
                              '3',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: textSize,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          setValueInNewMove(3);
                        }),
                    InkWell(
                        child: Container(
                          width: 40,
                          height: 35,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius:
                              BorderRadius.all(Radius.circular(11)),
                              color: Color(0x22000000)),
                          child: Center(
                            child: Text(
                              '5',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: textSize,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          setValueInNewMove(5);
                        }),
                    InkWell(
                        child: Container(
                          width: 40,
                          height: 35,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius:
                              BorderRadius.all(Radius.circular(11)),
                              color: Color(0x22000000)),
                          child: Center(
                            child: Text(
                              '7',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: textSize,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          setValueInNewMove(7);
                        }),
                    InkWell(
                        child: Container(
                          width: 40,
                          height: 35,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius:
                              BorderRadius.all(Radius.circular(11)),
                              color: Color(0x22000000)),
                          child: Center(
                            child: Text(
                              '9',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: textSize,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          setValueInNewMove(9);
                        }),
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
                    InkWell(
                        child: Container(
                          width: 40,
                          height: 35,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius:
                              BorderRadius.all(Radius.circular(11)),
                              color: Color(0x22000000)),
                          child: Center(
                            child: Text(
                              '2',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: textSize,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          setValueInNewMove(2);
                        }),
                    InkWell(
                        child: Container(
                          width: 40,
                          height: 35,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius:
                              BorderRadius.all(Radius.circular(11)),
                              color: Color(0x22000000)),
                          child: Center(
                            child: Text(
                              '4',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: textSize,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          setValueInNewMove(4);
                        }),
                    InkWell(
                        child: Container(
                          width: 40,
                          height: 35,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius:
                              BorderRadius.all(Radius.circular(11)),
                              color: Color(0x22000000)),
                          child: Center(
                            child: Text(
                              '6',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: textSize,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          setValueInNewMove(6);
                        }),
                    InkWell(
                        child: Container(
                          width: 40,
                          height: 35,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius:
                              BorderRadius.all(Radius.circular(11)),
                              color: Color(0x22000000)),
                          child: Center(
                            child: Text(
                              '8',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: textSize,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          setValueInNewMove(8);
                        }),
                    InkWell(
                        child: Container(
                          width: 40,
                          height: 35,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius:
                              BorderRadius.all(Radius.circular(11)),
                              color: Color(0x22000000)),
                          child: Center(
                            child: Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: textSize,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          setValueInNewMove(0);
                        }),
                  ],
                ),
              )
            ]));
  }

  clearAllTextFields() {
    setState(() {
      valueNewMove = [' ', ' ', ' ', ' '];
    });
  }

  checkMove() {
    if (valueNewMove.contains(' ')) {
      _showSnackBar(context, 'Some cell are empty!');
      return;
    }

    MoveModel newMove = MoveModel((movesList.length + 1).toString(),
        '${valueNewMove[0] + valueNewMove[1] + valueNewMove[2] +
            valueNewMove[3]}');

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
      clearAllTextFields();
    });

    scroll();
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  getClickedTextColor(int position) {
    if (textActive[position]) {
      return Colors.white;
    } else {
      return Colors.black54;
    }
  }

  getClickedBorderColor(int position) {
    if (textActive[position]) {
      return Colors.blue[700];
    } else {
      return Colors.black54;
    }
  }

  getBackgroundColor(int position) {
    if (textActive[position]) {
      return Colors.blue[300];
    } else {
      return Color(0x22000000);
    }
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

  setValueInNewMove(int position) {
    if (!textActive.contains(true)) return;

    setState(() {
      if (valueNewMove.contains(position.toString())) {
        valueNewMove[valueNewMove.indexOf(position.toString())] = ' ';
      }
      valueNewMove[textActive.indexOf(true)] = position.toString();
      textActive = [false, false, false, false];
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

  showStartAlert() {}
}
