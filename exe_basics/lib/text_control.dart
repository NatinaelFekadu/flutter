import 'package:exe_basics/text_content.dart';
import 'package:flutter/material.dart';

class TextControl extends StatefulWidget {
  @override
  State<TextControl> createState() => _TextControlState();
}

class _TextControlState extends State<TextControl> {
  String _textContent = 'Some content';
  void _changeTextHandler() {
    setState(() {
      _textContent = _textContent == 'Some content'
          ? 'Some other content'
          : 'Some content';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _changeTextHandler,
            child: const Text('Change Text'),
          ),
          TextContent(_textContent)
        ],
      ),
    );
  }
}
