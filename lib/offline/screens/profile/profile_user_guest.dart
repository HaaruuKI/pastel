import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileUserGuest extends StatefulWidget {
  const ProfileUserGuest({super.key});

  @override
  _ProfileUserGuestState createState() => _ProfileUserGuestState();
}

class _ProfileUserGuestState extends State<ProfileUserGuest> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _signInWithEmailAndPassword();
              },
              child: const Text('Sign In'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'register');
              },
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;

      if (user != null) {
        // El inicio de sesión fue exitoso, puedes redirigir a la siguiente pantalla
        // Navigator.pushNamed(context, 'nextScreen');
        // print('Registration successful: ${user.uid}');
        // print('Registration successful: ${user.email}');

        // Get the user's data from Firestore
        final DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (snapshot.exists) {
          final userData = snapshot.data();
          final String? userName = (userData as Map<String, dynamic>)['name'];
          print('User Name: $userName');
        } else {
          print('User data not found');
        }

        Navigator.pushNamed(context, 'navBar');
      } else {
        // El inicio de sesión falló
        print('Inicio de sesión fallido');
      }
    } catch (e) {
      // Ocurrió un error durante el inicio de sesión
      print('Error durante el inicio de sesión: $e');
    }
  }
}
