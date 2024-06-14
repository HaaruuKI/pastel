import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BtnBack extends StatelessWidget {
  const BtnBack({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(CupertinoIcons.back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
