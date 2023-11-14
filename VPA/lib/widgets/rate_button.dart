import 'package:flutter/material.dart';

class AdButton extends StatelessWidget {
  final Function() onPressed;

  const AdButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.star),
      onPressed: () {
        onPressed();
      },
    );
  }
}
