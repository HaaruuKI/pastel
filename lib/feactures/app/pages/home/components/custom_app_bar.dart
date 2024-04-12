import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pastel/feactures/app/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: yellowPastel,
      elevation: 0,
      actions: <Widget>[
        Row(
          children: [
            IconButton(
              icon: Icon(CupertinoIcons.search),
              // SvgPicture.asset("assets/icons/search.svg"),
              onPressed: () {
                Navigator.pushNamed(context, 'search');
              },
            ),
            if (FirebaseAuth.instance.currentUser != null)
              IconButton(
                icon: Icon(CupertinoIcons.cart),
                // SvgPicture.asset("assets/icons/search.svg"),
                onPressed: () {
                  Navigator.pushNamed(context, 'cartStore');
                },
              ),
            SizedBox(width: kDefaultPaddin / 2),
          ],
        ),
      ],
    );
  }
}
