import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int _score;
  final Function _resetQuiz;
  const Result(this._score, this._resetQuiz);

  String get resultPhrase {
    var resultText = 'You did it' + _score.toString();
    if (_score <= 8) {
      resultText = 'You are awesome';
    } else if (_score <= 16) {
      resultText = 'Pretty likeable';
    } else if (_score < 20) {
      resultText = 'You are strange';
    } else if (_score <= 30) {
      resultText = 'You are out of the world';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: <Widget>[
      Text(resultPhrase,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center),
      FlatButton(
        child: Text('Restart Quiz!',style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),),
        onPressed: _resetQuiz,
      )
    ]));
  }
}
