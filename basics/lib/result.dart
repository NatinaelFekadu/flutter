import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback restartQuiz;

  const Result(this.resultScore, this.restartQuiz, {super.key});

  String get resultPhrase {
    String resultText;
    if (resultScore <= 8) {
      resultText = 'You are awesome and innocent';
    } else if (resultScore <= 12) {
      resultText = 'You are pretty likebale';
    } else if (resultScore <= 16) {
      resultText = 'You are ... strange';
    } else {
      resultText = 'You are so bad';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          resultPhrase,
          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        TextButton(
          style: TextButton.styleFrom(
              padding: const EdgeInsets.all(5),
              backgroundColor: const Color.fromARGB(255, 176, 39, 108),
              foregroundColor: Colors.white),
          onPressed: restartQuiz,
          child: const Text('Restart'),
        ),
      ],
    ));
  }
}
