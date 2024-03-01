import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pastel/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: yellowPastel,
      elevation: 0,
      // leading: IconButton(
      //   icon: Icon(CupertinoIcons.arrow_left),
      //   // SvgPicture.asset(
      //   //   'assets/icons/back.svg',
      //   //   colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
      //   onPressed: () => Navigator.pushNamed(context, 'homePage'),
      // ),
      actions: <Widget>[
        IconButton(
          icon: Icon(CupertinoIcons.search),
          // SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {
            Navigator.pushNamed(context, 'search');
          },
        ),
        IconButton(
          icon: Icon(CupertinoIcons.cart),
          // SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {
            Navigator.pushNamed(context, 'cartStore');
          },
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
