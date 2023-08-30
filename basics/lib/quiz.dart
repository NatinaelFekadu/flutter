import 'package:flutter/material.dart';

import 'package:first_app/answer.dart';
import 'package:first_app/question.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;
  const Quiz(
      {super.key,
      required this.questions,
      required this.questionIndex,
      required this.answerQuestion});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(questions[questionIndex]['questionText'] as String),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) => Answer(() => answerQuestion(answer['score']),
                answer['text'] as String))
            .toList()
      ],
    );
  }
}
