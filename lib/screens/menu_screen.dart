import 'package:first_flutter_app/screens/game_info_screen.dart';
import 'package:first_flutter_app/screens/how_to_play_screen.dart';
import 'package:first_flutter_app/screens/multi_mode_screen.dart';
import 'package:first_flutter_app/screens/settings_screen.dart';
import 'package:first_flutter_app/screens/single_mode_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Menu with 5 buttons [multi_player, single_player, how_to_play, game_info, settings]

class MenuScreen extends StatelessWidget {
  final String prefKey = 'NotFirstStart';
  final backgroundColor = Colors.blue[100];

  Future<bool> initPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getKeys().contains(prefKey);
  }

  setNotFirstStart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(prefKey, true);
  }

  @override
  Widget build(BuildContext context) {
    initPref().then((bool value) {
      if (!value) {
        print(value.toString());
        navigateToHowToPlay(context, 'Skip');
        setNotFirstStart();
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

  navigateToSingleModeGame(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SingleModeGameScreen()),
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
            navigateToSingleModeGame(context);
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
}
