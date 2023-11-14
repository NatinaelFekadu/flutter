import 'package:flutter/material.dart';

class ShareButton extends StatelessWidget {
  final Function() onPressed;

  const ShareButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.share),
      onPressed: () {
        onPressed();
      },
    );
  }
}
