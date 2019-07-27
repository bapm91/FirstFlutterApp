import 'package:flutter/material.dart';

//Text (rules of the game with an explanation of how to play)
//and Button (Skip - for first start, or OK - for else.)

class HowToPlay extends StatelessWidget {
  final buttonText;

  HowToPlay(this.buttonText);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                //TODO need translate to english
                'Цель игры - отгадать уникальное число, где не повторяются цифры.'
                '\n\nНа введенное Вами число дается подсказка из двух цифр:'
                '\n 1я - колличество угаданых цифр;'
                '\n 2я - колличество угаданых цифр, которые на своем месте.'
                '\n\nНа пример, загаданное число 4836. Вы ввели 1234. В ответ будет дана подсказка "2:1". Угадано две цифры: 3 и 4. Из них одна стоит на своём месте: 3.'
                '\n 1) 1234 - 2:1'
                '\n\n\n\nУдачи в головоломке!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 19,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            ButtonTheme(
                minWidth: 100,
                height: 30,
                child: RaisedButton(
                  child: Text(buttonText),
                  textColor: Colors.white,
                  onPressed: () => Navigator.pop(context),
                ))
          ],
        ),
      ),
    );
  }
}
