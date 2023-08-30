import 'package:flutter/material.dart';

class TextContent extends StatelessWidget {
  final String textContent;

  const TextContent(this.textContent, {super.key});
  @override
  Widget build(BuildContext context) {
    return Text(textContent);
  }
}
