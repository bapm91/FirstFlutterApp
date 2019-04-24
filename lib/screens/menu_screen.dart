import 'dart:async';

import 'package:first_flutter_app/screens/game_info_screen.dart';
import 'package:first_flutter_app/screens/how_to_play_screen.dart';
import 'package:first_flutter_app/screens/multi_mode_screen.dart';
import 'package:first_flutter_app/screens/settings_screen.dart';
import 'package:first_flutter_app/screens/single_mode_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Menu with 5 buttons [multi_player, single_player, how_to_play, game_info, settings]

class MenuScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MenuScreenState();
  }
}

class MenuScreenState extends State<MenuScreen> {
  final String prefKey = 'NotFirstStart';
  final backgroundColor = Colors.blue[100];

  Future<bool> initPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getKeys() != null &&
        prefs.getKeys().contains(prefKey) == true &&
        prefs.getBool(prefKey) != false) {
      return true;
    }
    return false;
  }

  setNotFirstStart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(prefKey, true);
  }

  @override
  Widget build(BuildContext context) {
    initPref().then((bool value) {
      print('======================$value');
      if (!value) {
        setNotFirstStart();
        navigateToHowToPlay(context, 'Skip');
      }
    });

    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: Center(
          child: getButtons(context),
        ),
      ),
    );
  }

  navigateToMultiModeGame(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MultiModeGameScreen()),
    );
  }

  navigateToSingleModeGame(BuildContext context, DifficultyLevel level) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SinglePlayerMode(level: level)),
    );
  }

  navigateToHowToPlay(BuildContext context, String buttonText) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HowToPlay(buttonText)),
    );
  }

  navigateToInfo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameInfo()),
    );
  }

  navigateToSettingsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsScreen()),
    );
  }

  Widget customStyledButton({String buttonText, VoidCallback onPressed}) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: ButtonTheme(
          minWidth: 200.0,
          height: 40.0,
          child: RaisedButton(
            padding: EdgeInsets.fromLTRB(45, 8, 45, 8),
            child: Text(buttonText),
            textColor: Colors.white,
            onPressed: onPressed,
          )),
    );
  }

  getButtons(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        customStyledButton(
          buttonText: 'Multiplayer',
          onPressed: null,
        ),
        customStyledButton(
          buttonText: 'Singleplayer',
          onPressed: () {
            showDifficultyAlert();
          },
        ),
        Padding(
            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: Container(
              width: 40,
              height: 40,
            )),
        customStyledButton(
          buttonText: 'How to play',
          onPressed: () {
            navigateToHowToPlay(context, 'Ok');
          },
        ),
        customStyledButton(
          buttonText: 'Settings',
          onPressed: () {
            navigateToSettingsScreen(context);
          },
        ),
        customStyledButton(
          buttonText: 'Game info',
          onPressed: () {
            navigateToInfo(context);
          },
        ),
      ],
    );
  }

  DifficultyLevel currentLevel = DifficultyLevel.EASY;

  showDifficultyAlert() {
    List<DropdownMenuItem<DifficultyLevel>> _dropDownMenuItems =
        getDropDownMenuItems();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          titlePadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(9)),
              side: BorderSide(
                  color: Colors.blue[800], width: 2, style: BorderStyle.solid)),
          title: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(9), topRight: Radius.circular(9)),
                gradient: LinearGradient(
                    colors: <Color>[Colors.blue[900], Colors.blue[100]])),
            child: Text(
              "Singleplayer",
              style: TextStyle(color: Colors.white),
            ),
          ),
          content: Container(
            height: 80,
            color: Colors.grey[300],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 10,
                ),
                new Text(
                  "Choose your difficulty level?",
                  style: TextStyle(color: Colors.blue[900]),
                ),
                DropdownButton(
                  value: currentLevel,
                  items: _dropDownMenuItems,
                  onChanged: (DifficultyLevel level) {
                    setState(() {
                      currentLevel = level;
                      Navigator.of(context).pop();
                      showDifficultyAlert();
                    });
                  },
                )
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: Text("Start"),
              onPressed: () {
                Navigator.of(context).pop();
                navigateToSingleModeGame(context, currentLevel);
              },
            ),
          ],
        );
      },
    );
  }

  List<DropdownMenuItem<DifficultyLevel>> getDropDownMenuItems() {
    List<DropdownMenuItem<DifficultyLevel>> items = List();
    for (DifficultyLevel level in DifficultyLevel.values) {
// here we are creating the drop down menu items, you can customize the item right here
// but I'll just use a simple text for this
      items.add(DropdownMenuItem(
        value: level,
        child: Text(getLevelText(level)),
      ));
    }
    return items;
  }

  String getLevelText(DifficultyLevel level) {
    if (level == DifficultyLevel.NORMAL) {
      return 'Normal';
    } else if (level == DifficultyLevel.HARD) {
      return 'Hard';
    } else if (level == DifficultyLevel.MASTER) {
      return 'Master';
    } else if (level == DifficultyLevel.PRO) {
      return 'Pro';
    } else {
      return 'Easy';
    }
  }
}
