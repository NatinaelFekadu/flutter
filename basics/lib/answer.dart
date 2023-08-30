import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback selectHandler;
  final String answerText;

  const Answer(this.selectHandler, this.answerText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.blue)),
        onPressed: selectHandler,
        child: Text(answerText),
      ),
    );
  }
}
