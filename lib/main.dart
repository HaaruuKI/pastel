// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pastel/constants.dart';
// import 'package:pastel/firebase_options.dart';
import 'package:pastel/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDth1VpVEf4ABoLf1SqnPFLgFyFHlBDFXE",
        authDomain: "pasteles-882b1.firebaseapp.com",
        databaseURL: "https://pasteles-882b1-default-rtdb.firebaseio.com",
        projectId: "pasteles-882b1",
        storageBucket: "pasteles-882b1.appspot.com",
        messagingSenderId: "52268043572",
        appId: "1:52268043572:web:cbf2b78dee4fea353aa961"),
  );
  runApp(MyApp());
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Flutter Way',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: routes,
      initialRoute: 'navBar',
      // FirebaseAuth.instance.currentUser != null
      //     ? 'homePage'
      //     : 'homePageGuest',
    );
  }
}
