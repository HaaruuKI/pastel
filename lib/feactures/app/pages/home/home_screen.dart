// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pastel/feactures/app/constants.dart';
import 'package:pastel/feactures/app/pages/home/components/custom_app_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../auth/models/Product.dart';
import '../details/details_screen.dart';
// import 'components/categorries.dart';
import 'components/item_card.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomAppBar(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                child: Text(
                  "Reposteria",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              // Categories(),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                  child: GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: kDefaultPaddin,
                      crossAxisSpacing: kDefaultPaddin,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) => ItemCard(
                      product: Product(
                        // id: snapshot.data!.docs[index].id,
                        title: snapshot.data!.docs[index]['name'],
                        description: snapshot.data!.docs[index]['description'],
                        price: snapshot.data!.docs[index]['price'],
                        image: snapshot.data!.docs[index]['img_url'],
                        // size: snapshot.data!.docs[index]['size'].toDouble(),
                        size: 1,
                      ),
                      press: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: DetailsScreen(
                            product: Product(
                              // id: snapshot.data!.docs[index].id,
                              title: snapshot.data!.docs[index]['name'],
                              description: snapshot.data!.docs[index]
                                  ['description'],
                              price: snapshot.data!.docs[index]['price'],
                              image: snapshot.data!.docs[index]['img_url'],
                              // size: snapshot.data!.docs[index]['size']
                              //     .toDouble(),
                              size: 1,
                            ),
                          ),
                          withNavBar: false, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                        // // Navigator.push(
                        // //   context,
                        // //   MaterialPageRoute(
                        // //     builder: (context) => DetailsScreen(
                        // //       product: Product(
                        // //         // id: snapshot.data!.docs[index].id,
                        // //         title: snapshot.data!.docs[index]['name'],
                        // //         description: snapshot.data!.docs[index]
                        // //             ['description'],
                        // //         price: snapshot.data!.docs[index]['price'],
                        // //         image: snapshot.data!.docs[index]['img_url'],
                        // //         // size: snapshot.data!.docs[index]['size']
                        // //         //     .toDouble(),
                        // //         size: 1,
                        // //       ),
                        // //     ),
                        // //   ),
                        // );
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
