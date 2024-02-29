import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cart_counter.dart';

class CounterWithFavBtn extends StatefulWidget {
  @override
  _CounterWithFavBtnState createState() => _CounterWithFavBtnState();
}

class _CounterWithFavBtnState extends State<CounterWithFavBtn> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CartCounter(),
        InkWell(
          onTap: () {
            setState(() {
              isPressed = !isPressed;
            });
          },
          child: Icon(
            isPressed ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
            size: 32,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
