import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextButton extends StatelessWidget {
  final String _text;
  final VoidCallback _handler;

  const AdaptiveTextButton(this._text, this._handler, {super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: _handler,
            child: Text(
              _text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        : TextButton(
            onPressed: _handler,
            child: Text(
              _text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}
