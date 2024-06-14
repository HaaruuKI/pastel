// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pastel/feactures/app/pages/profile/profile_user.dart';
import 'package:pastel/feactures/app/pages/profile/profile_user_guest.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Perfil'),
      // ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            if (FirebaseAuth.instance.currentUser?.uid != null)
              const ProfieUser()
            else
              const ProfileUserGuest()
          ],
        ),
      ),
    );
  }
}
