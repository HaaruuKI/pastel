import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pastel/feactures/app/constants.dart';
import 'package:pastel/feactures/app/pages/cart_store/cart_store.dart';
import 'package:pastel/feactures/app/pages/search/search.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

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
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: Search(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
            ),
            if (FirebaseAuth.instance.currentUser != null)
              IconButton(
                icon: Icon(CupertinoIcons.cart),
                // SvgPicture.asset("assets/icons/search.svg"),
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: CartStore(),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
              ),
            SizedBox(width: kDefaultPaddin / 2),
          ],
        ),
      ],
    );
  }
}
