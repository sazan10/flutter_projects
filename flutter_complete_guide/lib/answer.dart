import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String answer;
  Answer(this.selectHandler,this.answer);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        color: Colors.blue,
        child: Text(answer),
        onPressed: selectHandler,
      ),
      width: double.infinity,
    );
  }
}
