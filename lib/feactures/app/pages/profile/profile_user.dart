// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pastel/feactures/app/pages/home/home_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ProfieUser extends StatefulWidget {
  const ProfieUser({super.key});

  @override
  State<ProfieUser> createState() => _ProfieUserState();
}

class _ProfieUserState extends State<ProfieUser> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? user;
  String userEmail = "";
  String userName = "";

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    user = _auth.currentUser;
    if (user != null) {
      if (user!.providerData
          .any((provider) => provider.providerId == 'google.com')) {
        _getGoogleUserData();
      } else {
        _getEmailPasswordUserData();
      }
    }
  }

  Future<void> _getGoogleUserData() async {
    userName = user!.displayName ?? "";
    userEmail = user!.email ?? "";
  }

  Future<void> _getEmailPasswordUserData() async {
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    if (userData.exists) {
      setState(() {
        userName = userData.get('name');
        userEmail = userData.get('email');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (user != null)
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  'https://img.freepik.com/vector-premium/icono-perfil-usuario-estilo-plano-ilustracion-vector-avatar-miembro-sobre-fondo-aislado-concepto-negocio-signo-permiso-humano_157943-15752.jpg'),
            ),
          SizedBox(height: 16),
          Text(
            userName,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            userEmail,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(CupertinoIcons.square_arrow_right, size: 50),
                onPressed: () async {
                  await _auth.signOut();
                  await _googleSignIn.signOut();
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: HomeScreen(),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
