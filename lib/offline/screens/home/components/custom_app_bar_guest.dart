import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pastel/feactures/app/constants.dart';

class CustomAppBarGuest extends StatelessWidget {
  const CustomAppBarGuest({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(CupertinoIcons.search),
          onPressed: () {
            Navigator.pushNamed(context, 'search');
          },
        ),
        // IconButton(
        //   icon: Icon(CupertinoIcons.cart),
        //   onPressed: () {
        //     Navigator.pushNamed(context, 'cartStore');
        //   },
        // ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
